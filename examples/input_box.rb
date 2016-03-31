require 'rdialogs'

d = RDialogs.new

# Simple input box.
name = d.input_box("What's your name?")

puts "Hello #{name || 'anonymous coward'}."


# Input box with default value and some optional parameters.
color = d.input_box("What's your favotite color?", 'Blue', title: 'This is title.', full_buttons: true)

case color
when false
  puts 'Canceled.'
when ''
  puts 'No input was submitted.'
else
  puts "#{color} is indeed a beautiful color."
end
