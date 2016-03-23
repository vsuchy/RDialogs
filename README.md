# RDialogs

A ruby wrapper for
[ncurses dialog](https://en.wikipedia.org/wiki/Dialog_(software))
and [newt whiptail](https://en.wikipedia.org/wiki/Newt_(programming_library)).

RDialogs allows ruby scripts to display dialog boxes to the user for informational purposes,
or to get input from the user in a friendly way.

[![Build Status](https://travis-ci.org/vsuchy/RDialogs.svg?branch=master)](https://travis-ci.org/vsuchy/RDialogs)
[![Code Climate](https://codeclimate.com/github/vsuchy/RDialogs/badges/gpa.svg)](https://codeclimate.com/github/vsuchy/RDialogs)
[![Test Coverage](https://codeclimate.com/github/vsuchy/RDialogs/badges/coverage.svg)](https://codeclimate.com/github/vsuchy/RDialogs/coverage)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rdialogs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rdialogs


## Usage

```ruby
d = RDialogs.new('whiptail')
d.message_box('Hello World!')

if name = d.input_box("What's your name")
  puts "Hello #{name}".
end
```

Supported dialog types:
* Info Box ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/info_box.rb))
* Message Box ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/message_box.rb))
* Yes/No Box ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/yesno_box.rb))
* Input Box ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/input_box.rb))
* Password Box ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/password_box.rb))
* Menu ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/menu.rb))
* Check List ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/check_list.rb))
* Radio List ([examples](https://github.com/vsuchy/RDialogs/blob/master/examples/radio_list.rb))

Optional parameters:
* title
* back_title
* yes_button
* no_button
* ok_button
* cancel_button
* default_no
* no_cancel
* default_item
* no_item
* no_tags
* clear
* full_buttons
* scroll_text
* top_left


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vsuchy/RDialogs.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
