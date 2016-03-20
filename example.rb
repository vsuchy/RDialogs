$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rdialogs'

d = RDialogs.new('whiptail')

if d.yesno_box('Do you want to test RDialogs?')[:status]
  name = d.input_box("What's your name?")[:output]

  unless name.empty?
    d.message_box("Hello #{name}!", { full_buttons: true })
  end
else
  d.message_box('Maybe later...')
end
