Notes on use of Thor

I was thinking about writing scripts in bash to simulate the Thor inject before/after
functionality. This made me very curious about how the Rails generator (which uses thor)
"destroy" capability works. That led me to read the source for Thor and its specs to
see how this is done. See item 4.

1. When you do `thor ex:command` note that `command` must match the
   method name (not the name from the `desc` declaration).
2. If you have a method with an underscore in it, thor will convert dashes to
   underscores in the command name. E.g., `thor ex:create-force` will work with
   a method `create_force`
3. There can be surprises if you inject something near the beginning of the file,
   and then try to inject the same text somewhere near the end. The text at the
   beginning will be matched so you may not find that the 2nd injection works.
4. To revoke an action, you can do `self.behavior = :revoke`. See the `revoke`
   method in the example.

Other actions

say, ask, yes?, no?, add_file, remove_file, copy_file, template, directory, inside, run, inject_into_file

See https://www.rubydoc.info/gems/thor/Thor/Shell/Basic and https://www.rubydoc.info/gems/thor/Thor/Actions
