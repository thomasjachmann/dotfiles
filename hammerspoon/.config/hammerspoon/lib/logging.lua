local logging = {}

local hs_logger = require 'hs.logger'

local loggers = {}

function logging.addLogger(logger)
  table.insert(loggers, logger)
  return logger
end

function logging.setLogLevel(level)
  for i, logger in ipairs(loggers) do
    logger.setLogLevel(level)
  end
end

function logging.new(component, name)
  local logger = logging.addLogger(hs_logger.new(name))
  component.setLogLevel = logger.setLogLevel
  component.getLogLevel = logger.getLogLevel
  return logger
end

return logging
