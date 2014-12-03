local mail = {}

local applescript = require "mjolnir._asm.hydra.applescript"

function mail.init()
  applescript.applescript('tell application "Mail" to set selected mailboxes of message viewer 1 to inbox')
end

return mail
