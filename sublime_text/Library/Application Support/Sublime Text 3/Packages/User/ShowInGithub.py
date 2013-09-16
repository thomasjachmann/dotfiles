import sublime, sublime_plugin, os

class ShowCommitInGithub(sublime_plugin.TextCommand):
  def run(self, edit):
    repository = os.popen('git remote -v show | grep @github.com | grep "(fetch)" | head -n 1 | sed "s/^.*@github.com:\\(.*\\)\\(\\.git\\).*$/\\1/"').read().strip()
    for selection in self.view.sel():
      sha1 = self.view.substr(selection)
      os.popen('open https://github.com/%s/commit/%s' % (repository, sha1))

# class ShowFileInGithub(sublime_plugin.TextCommand):
