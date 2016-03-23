require 'rdialogs'

d = RDialogs.new

# Simple message box.
d.message_box('Hello world.')

# Message box with some optional parameters.
d.message_box('Example message box.', width: 70, height: 15, title: 'This is title.')
