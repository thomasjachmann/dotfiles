// Phoenix config mainly for app switching and partly for window resizing


// extend api //////////////////////////////////////////////////////////////////

api.appscript = function() {
  var args = _.chain(arguments)
    .map(function(cmd) { return ['-e', cmd]; })
    .flatten()
    .value();
  this.runCommand('/usr/bin/osascript', args);
};

api.bindToHyper = function(mappings) {
  return _(mappings).map(function(func, key) {
    return api.bind(key, ['cmd', 'alt', 'ctrl', 'shift'], func);
  })
};


// extend App //////////////////////////////////////////////////////////////////

App.byTitle = function(title, callback) {
  var apps = _(this.runningApps()).filter(function(app) {
    return app.title() === title;
  });
  if (callback) _(apps).each(callback);
  return apps;
};

App.activate = function(title) {
  var apps = App.byTitle(title, function(app) { app.activate() });
  if (_.isEmpty(apps)) api.launch(title);
};

App.prototype.windows = function() {
  var windows = {normal: [], minimized: []};
  _(this.allWindows()).each(function(win) {
    if (win.isNormalWindow()) windows.normal.push(win);
    else if (win.isWindowMinimized()) windows.minimized.push(win);
  });
  return windows;
};

App.prototype.activate = function() {
  this.show();
  var windows = this.windows();
  if (!_.isEmpty(windows.normal)) {
    windows.normal[0].focusWindow();
  } else if (!_.isEmpty(windows.minimized)) {
    windows.minimized[0].unMinimize();
    windows.minimized[0].focusWindow();
  } else {
    this.kill();
    api.launch(this.title());
  }
};


// extend Screen ///////////////////////////////////////////////////////////////

Screen.prototype.calculateFrame = function(x, y, width, height) {
  var frame = this.frameWithoutDockOrMenu();
  return {
    x:      x * frame.width + frame.x,
    y:      y * frame.height + frame.y,
    width:  width * frame.width,
    height: height * frame.height,
    eql:    function(other) {
      return this.x == other.x && this.y == other.y && this.width == other.width && this.height == other.height;
    }
  };
};


// extend Window ///////////////////////////////////////////////////////////////

// somehow you have to store these externally, just attaching the remembered
// frame to the window doesn't work
var rememberedFrames = {};

Window.prototype.move = function(sizes) {
  // calculate frames for sizes on current screen
  var screen = this.screen();
  var frames = _(sizes).map(function(size) {
    return screen.calculateFrame(size[0], size[1], size[2], size[3]);
  });

  // determine the next size to load
  var current = this.frame();
  var index = _(frames).map(function(frame) {
    return frame.eql(current);
  }).indexOf(true) + 1;

  if (index == 0) {
    rememberedFrames[this] = current;
    this.setFrame(frames[index]);
  } else if (index == frames.length) {
    if (rememberedFrames[this]) {
      this.setFrame(rememberedFrames[this]);
      delete rememberedFrames[this];
    } else {
      this.setFrame(frames[0]);
    }
  } else {
    this.setFrame(frames[index]);
  }
};


// function factories (There, I said it!) //////////////////////////////////////

// Launches an app by name and optionally executes an initialization function.
// This simulates a click on the dock icon.
function launch(name, func) {
  return function() {
    api.launch(name);
    if (func) func();
  };
}

// Activates an app by title.
// This goes throw the apps windows and intelligently selects the one to focus.
// It is mainly used for Chrome SSB apps that cannot just be launched.
function activate(title) {
  return function() { App.activate(title); }
}

// Moves the currently focused window.
// You can specify multiple size definitions and this will cycle through them.
function move() {
  var sizes = arguments;
  return function() {
    var win = Window.focusedWindow();
    if (win) win.move(sizes);
  };
}


// bindings ////////////////////////////////////////////////////////////////////

api.bindToHyper({
  // window sizing
  1: move([0, 0, 1, 1]),          // full screen
  2: move(
    [0,   0, 0.5, 1],             // left half
    [0.5, 0, 0.5, 1]              // right half
  ),
  3: move(
    [0,   0, 1/3, 1],             // left third
    [0,   0, 2/3, 1],             // left two thirds
    [1/3, 0, 1/3, 1],             // middle third
    [1/3, 0, 2/3, 1],             // right two thirds
    [2/3, 0, 1/3, 1]              // right third
  ),
  4: move(
    [0,   0,   0.5, 0.5],         // top left quarter
    [0.5, 0,   0.5, 0.5],         // top right quarter
    [0,   0.5, 0.5, 0.5],         // bottom left quarter
    [0.5, 0.5, 0.5, 0.5]          // bottom right quarter
  ),

  // app shortcuts
  '+': activate('Google+'),
  0: launch('TickTrack SSB'),     // 0 as a number for tracking numbers
  a: launch('Adium'),
  b: launch('Safari'),            // b for browser
  // TODO this still doesn't work properly when chrome isn't launched before the other chrome apps
  c: launch('Google Chrome'),
  //d: launch('Sequel Pro'),        // d for database
  d: launch('Calendar'),          // d for dates
  e: launch('MacVim'),            // e for editor
  f: launch('Finder'),
  //f: launch('Path Finder'),
  g: launch('GitX'),
  i: launch('Textual'),           // i for irc
  m: launch('Mail', function() {
    api.appscript('tell application "Mail" to set selected mailboxes of message viewer 1 to inbox');
  }),
  n: launch('Echofon'),           // n for noise
  o: launch('Opera Next'),
  p: activate('Trello'),          // p for project management
  s: launch('Skype'),
  t: launch('iTerm'),             // t for terminal

  w: function() { Window.focusedWindow().app().hide(); },
});
