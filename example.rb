$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rdialogs'

d = RDialogs.new('whiptail')

if d.yesno_box('Do you want to test RDialogs?', width: 70)[:status]
  name = d.input_box("What's your name?")[:output]

  d.message_box("Hello #{name}!", full_buttons: true) unless name.empty?
else
  d.message_box('Maybe later...')
end
