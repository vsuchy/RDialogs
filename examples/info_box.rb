require 'rdialogs'

d = RDialogs.new

# Simple info box.
d.info_box('Hello world.')

# Info box with some optional parameters.
d.info_box('Example info box.', width: 70, height: 15, title: 'This is title.')
