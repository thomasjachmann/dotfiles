local browser = {
  browsers = {},
  mappings = {},
}

local logger = require'lib.logging'.new(browser, 'lib.browser')

browser.browsers.firefox = "org.mozilla.firefox"
browser.browsers.chrome = "com.google.Chrome"
browser.browsers.tor = "org.torproject.torbrowser"
browser.browsers.default = browser.browsers.firefox

function findBundleID(host)
  for _, mapping in pairs(browser.mappings) do
    if host:find(mapping.pattern, 1, true) then
      return mapping.bundleID
    end
  end
end

function httpCallback(scheme, host, params, fullURL, senderPID)
  browser.open(fullURL, findBundleID(host))
end

function browser.addMapping(pattern, bundleID)
  table.insert(browser.mappings, { pattern = pattern, bundleID = bundleID })
end

function browser.start()
  if hs.urlevent.httpCallback then
    logger.w("hs.urlevent.httpCallback is already set, overwriting")
  end
  hs.urlevent.httpCallback = httpCallback
end

function browser.stop()
  hs.urlevent.httpCallback = null
end

function browser.open(url, bundleID)
  local bundleID = bundleID or browser.browsers.default
  hs.urlevent.openURLWithBundle(url, bundleID)
end

return browser
