require 'rdialogs'

d = RDialogs.new

# Simple yes/no box.
bacon = d.yesno_box('Do you like bacon?')

puts bacon ? 'You like bacon.' : 'Really?'


# Yes/No box with default value and some optional parameters.
hamlet = d.yesno_box('To be or not to be?', title: 'This is title.', default_no: true)

if hamlet
  puts 'To be.'
else
  puts 'Not to be :('
end
