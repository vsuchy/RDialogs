require 'rdialogs'

d = RDialogs.new

menu_items = {
  'Add User' => 'Add a user to the system.',
  'List Users' => 'List all users on the system.'
}

# Simple menu.
selected_action = d.menu('Choose action:', menu_items)

puts "You selected: #{selected_action || 'nothing'}."


# Menu with some optional parameters.
selected_action = d.menu('Choose action:', menu_items, title: 'This is title.', ok_button: 'GO')

if selected_action
  puts "Selected: #{selected_action}"
else
  puts 'Canceled.'
end
