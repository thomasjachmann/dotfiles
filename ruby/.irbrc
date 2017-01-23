IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:EVAL_HISTORY] = 10

def disable_persistent_irb_history
  IRB.conf[:AT_EXIT] = []
end
