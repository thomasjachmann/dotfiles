import sublime, sublime_plugin, tempfile, os

class RubyExecCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    # if not hasattr(self, 'outputView'):
    #   print("creating view")
    #   self.outputView = self.view.window().get_output_panel('RubyExec')
    # v = self.outputView
    v = self.view.window().get_output_panel('RubyExec')
    self.view.window().run_command("show_panel", {"panel": "output.RubyExec"})

    # get selected code
    selections = []
    for selection in self.view.sel():
      selections.append(self.view.substr(selection))
    code = '\n'.join(selections).strip('\n')

    # if there's no selected code, get all code
    if len(code) == 0:
      code = self.view.substr(sublime.Region(0, self.view.size()))

    # write code to a temporary file and execute it
    f = tempfile.NamedTemporaryFile()
    f.write(bytes(code, 'UTF-8'))
    f.flush()
    output = os.popen('chruby-exec -- ruby %s 2>&1' % f.name).read()
    f.close

    # write output to panel, scroll to the end and show the panel
    v.run_command('append', {'characters': output})
    v.show(v.size())
