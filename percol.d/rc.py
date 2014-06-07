# Prompt
percol.view.PROMPT  = ur"<bold><yellow>Q</yellow></bold>: %q"
percol.view.__class__.PROMPT = property(
    lambda self:
    ur"<bold><cyan>Q</cyan></bold> [a]: %q" if percol.model.finder.case_insensitive
    else ur"<bold><yellow>Q</yellow></bold> [A]: %q"
)

percol.view.prompt_replacees["F"] = lambda self, **args: self.model.finder.get_name()
percol.view.RPROMPT = ur"(%F) [%i/%I]"

# Keymap
percol.import_keymap({
    "C-j" : lambda percol: percol.command.select_next(),
    "C-k" : lambda percol: percol.command.select_previous(),
    "C-d" : lambda percol: percol.finish(),
    "C-c" : lambda percol: percol.cancel(),
})
