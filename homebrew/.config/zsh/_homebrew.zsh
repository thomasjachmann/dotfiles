# extend path for homebrew (/usr/local/bin is already in)
PATH=/usr/local/sbin:$PATH

# and for brew's npm
PATH=/usr/local/share/npm/bin:$PATH

# prevent homebrew from sending data home
HOMEBREW_NO_ANALYTICS=1

# prevent homebrew to update on each install (I'd rather do this manually to save time)
HOMEBREW_NO_AUTO_UPDATE=1

# prevent homebrew to cleanup automatically (I'd rather do this manually to choose deliberately)
HOMEBREW_NO_INSTALL_CLEANUP=1

# don't search github issues etc. on `brew search`
HOMEBREW_NO_GITHUB_API=1

HOMEBREW_DISPLAY_INSTALL_TIMES=1

# always use the internal tools instead of the system ones
HOMEBREW_FORCE_VENDOR_RUBY=1
HOMEBREW_FORCE_BREWED_GIT=1
