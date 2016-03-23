require 'rdialogs'

d = RDialogs.new

list_items = {
  'Add User' => ['Add a user to the system.', false],
  'List Users' => ['List all users on the system.', true]
}

# Simple radio list, "List Users" is checked by default.
selected_action = d.radio_list('Choose action:', list_items)

puts "You selected: #{selected_action || 'nothing'}."


# Radio list with some optional parameters.
selected_action = d.radio_list('Choose action:', list_items, title: 'This is title.', ok_button: 'GO')

case selected_action
  when false
    puts 'Canceled.'
  when ''
    puts 'Nothing was selected.'
  else
    puts "Selected: #{selected_action}"
end
