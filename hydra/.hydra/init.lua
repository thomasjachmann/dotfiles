hydra.douserfile "loader"
load(
"ext/appscript",
--"ext/modal",
"menu"
)

function bindtohyper(mappings)
  for key, fn in pairs(mappings) do
    hotkey.bind({"cmd", "alt", "ctrl", "shift"}, key, fn)
  end
end

function launch(app, fn)
  return function()
    application.launchorfocus(app)
    if (fn) then; fn(); end
  end
end

function hide()
  local win = window.focusedwindow()
  if (win) then; win:application():hide(); end
end

--bindtohyper({
  ---- app shortcuts
  --["+"] = launch("Google\\ Plus"),
  --["0"] = launch('TickTrack\\ SSB'),
  --a = launch("Adium"),
  --b = launch("Safari"),               -- b for browser
  --c = launch("Google\\ Chrome"),
  --d = launch("Calendar"),             -- d for dates
  ----d = launch('Sequel\\ Pro'),       -- d for database
  --e = launch("MacVim"),               -- e for editor
  --f = launch("Finder"),
  ----f = launch("Path\\ Finder"),
  --g = launch("GitX"),
  --i = launch("Textual"),              -- i for irc
  --m = launch("Mail", function()
    --ext.appscript('tell application "Mail" to set selected mailboxes of message viewer 1 to inbox')
  --end),
  --n = launch("Echofon"),              -- n for noise
  --o = launch("Opera Next"),
  --p = launch("Trello"),               -- p for project management
  --s = launch("Skype"),
  --t = launch("iTerm"),                -- t for terminal
  --x = launch("xScope"),

  --w = hide
--})
