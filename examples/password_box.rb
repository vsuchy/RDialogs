require 'rdialogs'

d = RDialogs.new

# Simple password box.
password = d.password_box('Enter your password.')

puts "Your password: #{password || 'n/a'}."


# Password box with default value and some optional parameters.
password = d.password_box('Enter your password', 'secret', title: 'This is title.', full_buttons: true)

case password
when false
  puts 'Canceled.'
when ''
  puts 'No input was submitted.'
else
  puts "Your password: #{password}."
end
