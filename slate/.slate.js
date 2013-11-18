slate.configAll({
  modalEscapeKey: 'esc',
  defaultToCurrentScreen: true,
  //nudgePercentOf: 'screenSize',
  //resizePercentOf: 'screenSize',
});

function appscript(cmds, wait) {
  return slate.shell('/usr/bin/osascript -e \'' + cmds.join('\' -e \'') + '\'', wait);
}

function currentSpotifyTrack() {
  return appscript(['tell application "Spotify" to set output to (name of current track) & " by " & (artist of current track) & " on " & (album of current track) & " by " & (album artist of current track)'], true);
}

function displayCurrentSpotifyTrack(win) {
  var track = currentSpotifyTrack();
  appscript(['tell application "LaunchBar" to display in large type "' + track + '"'], false);
}

function copyCurrentSpotifyTrack(win) {
  var track = currentSpotifyTrack();
  slate.shell('~/bin/copy-to-clipboard "' + track + '"', false);
}

function toggleVpn(name) {
  return function() {
    var connected = appscript(['tell application "Tunnelblick" to return state of first configuration where name is "' + name + '"'], true).indexOf("CONNECTED") != -1;
    var command = connected ? 'disconnect' : 'connect';
    appscript(['tell application "Tunnelblick" to ' + command + ' "' + name + '"'], false);
  }
}

function activate(app) {
  // this is standard
  var cmds = ['tell application "Finder" to open (path to application "' + app + '")'];
  // now the edge cases (apple's own apps, of course)
  switch(app) {
    case "Finder":
      cmds.length = 0
      cmds.push('tell application "Finder" to activate');
      cmds.push('if not (window 1 of application "Finder" exists) then tell application "Finder" to open path to home folder');
      break;
    case "Mail":
      cmds.push('tell application "Mail" to set selected mailboxes of message viewer 1 to inbox');
      break;
  }
  // and execute it all
  appscript(cmds, false);
}

function app(app) {
  return function(win) { activate(app); };
}

function move(x, y, w, h) {
  return slate.operation('move', {
    x: 'screenOriginX+screenSizeX*' + x,
    y: 'screenOriginY+screenSizeY*' + y,
    width: 'screenSizeX*' + w,
    height: 'screenSizeY*' + h
  });
}

var singleDoubleTimes = {};
function singleDouble(single, double) {
  var key = Math.random();
  return function(win) {
    var now = new Date().getTime(),
        last = singleDoubleTimes[key];
    if (last && (now - last) < 500) {
      double(win);
    } else {
      single(win);
    }
    singleDoubleTimes[key] = now;
  };
}

function bindToHyper(mappings, modal_key) {
  var modifier;
  if (modal_key == undefined) {
    modifier = ':shift,ctrl,alt,cmd';
  } else {
    modifier = ':' + modal_key + ',shift,ctrl,alt,cmd';
  }
  for (key in mappings) {
    mapping = mappings[key];
    slate.bind(key + modifier, mapping);
  }
}

bindToHyper({
  // alphanumeric keys (mainly app shortcuts)
  0: app('TickTrack SSB'),    // tt for ticktrack
  1: app('1Password'),
  a: app('Adium'),
  b: app('Safari'),           // b for browser
  c: app('Google Chrome'),
  d: app('Sequel Pro'),       // d for database
  e: app('Sublime Text'),     // e for editor
  f: app('Finder'),
  g: app('GitX'),
  i: app('/Applications/Textual.app'), // i for irc, Textual somehow isn't startable without the path, since path to application "Textual" fails
                                       // "somehow" probably means: there are more than two Textual apps (one additional in XCode's DerivedData folder)

  m: app('Mail'),
  n: app('Echofon'),          // n for noise
  o: app('Opera Next'),
  p: app('Trello'),           // p for project management
  q: singleDouble(            // q for qhatever
    displayCurrentSpotifyTrack,
    copyCurrentSpotifyTrack
  ),
  // r: app('Rested'),
  s: app('Skype'),
  t: app('iTerm'),            // t for terminal
  w: slate.opstr('hide current'),

  // control keys
  esc: slate.op('relaunch'),
  tab: slate.opstr('grid 1440x900:6,6'),
  '`': slate.operation('chain', {
    operations: [
      move(0,   0,   1,   1),   // fullscreen
      move(0,   0,   0.5, 1),   // left half
      move(0.5, 0,   0.5, 1),   // right half
      move(0,   0,   0.5, 0.5), // top left quarter
      move(0.5, 0,   0.5, 0.5), // top right quarter
      move(0,   0.5, 0.5, 0.5), // bottom left quarter
      move(0.5, 0.5, 0.5, 0.5)  // bottom right quarter
    ]
  })                          // < for cycling through window placements
});

bindToHyper({
  m: app('Yelp Mail'),
  d: app('Yelp Drive'),
  v: toggleVpn('qype')
}, 'z'); // y for yelp stuff - this is a bug: https://github.com/jigish/slate/issues/198

// since this file is in version control and used on multiple computers,
// allow to customize slate for a local machine by creating .slate.local.js
slate.source('~/.slate.local.js');

// function echo(message) {
//   slate.shell('/usr/bin/say "' + message + '"', true);
// }

// function hyper(key, whatToDo) {
//   slate.bind(key + ':ctrl;shift;alt;cmd', whatToDo);
// }

// function hyperApp(key, app) {
//   hyper(key, function(win) { activate(app); });
// }

// Direct Access To Applications
// Note: hjkl are already mapped to arrow keys by KeyRemap4MacBook
// hyperApp('1', '1Password');
// hyperApp('b', 'Safari');          // b for browser
// hyperApp('c', 'Google Chrome');
// hyperApp('d', 'Sequel Pro');      // d for database
// hyperApp('e', 'Sublime Text 2');  // e for editor
// hyperApp('f', 'Finder');
// hyperApp('g', 'GitX');
// hyperApp('i', 'Textual');
// hyperApp('m', 'Mail');
// hyperApp('n', 'Echofon');         // n for noise
// hyperApp('r', 'Rested');
// hyperApp('s', 'Skype');
// hyperApp('t', 'iTerm');           // t for terminal
// hyperApp('z', 'Yelp Mail');       // y for yelp mail - this is a bug: https://github.com/jigish/slate/issues/198

// Experiment with double presses
// var singleDoubleTimes = {};
// function singleDouble(key) {
//   hyper(key, function(win) {
//     var now = new Date().getTime(),
//         last = singleDoubleTimes[key];
//     if (last && (now - last) < 1000) {
//       slate.log("double " + key);
//     } else {
//       slate.log("single " + key);
//     }
//     singleDoubleTimes[key] = now;
//   });
// }
