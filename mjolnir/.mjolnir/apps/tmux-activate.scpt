on run(ttynum)
  set ttynum to "" & ttynum
  tell application "iTerm"
    activate
    repeat with myterm in terminals
      repeat with mysession in sessions of myterm
        set myttynum to get tty of mysession
        if myttynum = ttynum then
          tell mysession to select
          tell myterm to select
        end if
      end repeat
    end repeat
  end tell
end run
