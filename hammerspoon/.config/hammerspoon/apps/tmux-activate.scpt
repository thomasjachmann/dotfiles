on run(ttynum)
  set ttynum to "" & ttynum
  tell application "iTerm"
    activate
    repeat with mywin in windows
      repeat with mytab in tabs of mywin
        repeat with mysession in sessions of mytab
          set myttynum to get tty of mysession
          if myttynum = ttynum then
            tell mysession to select
            tell mytab to select
            tell mywin to select
          end if
        end repeat
      end repeat
    end repeat
  end tell
end run
