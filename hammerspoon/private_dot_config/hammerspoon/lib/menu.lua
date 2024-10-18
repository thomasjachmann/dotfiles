local menu = {}

local logger = require'lib.logging'.new(menu, 'lib.menu')

function menu.new(hint)
  return {
    check = function(item) return menu.check(hint, item) end,
    ticked = function(item) return menu.ticked(hint, item) end,
    click = function(item) return menu.click(hint, item) end,
  }
end

local function with_app(hint, fn)
  local app = hs.application.get(hint)
  if app == nil then
    logger.d("did not find app " .. hint)
  else
    logger.d("found app " .. hint .. ": " .. hs.inspect(app))
    return fn(app)
  end
end

local function with_menu_item(hint, item, fn)
  return with_app(hint, function(app)
    local menu_item = app:findMenuItem(item)
    if menu_item == nil then
      logger.d("did not find menu item " .. hs.inspect(item))
    else
      logger.d("found menu item " .. hs.inspect(item) .. ": " .. hs.inspect(menu_item))
      return fn(app, menu_item)
    end
  end)
end

function menu.check(hint, item)
  return with_menu_item(hint, item, function(app, menu_item)
    return menu_item ~= nil
  end)
end

function menu.ticked(hint, item)
  return with_menu_item(hint, item, function(app, menu_item)
    return menu_item.ticked
  end)
end

function menu.click(hint, item)
  with_app(hint, function(app)
    app:selectMenuItem(item)
  end)
end

return menu
