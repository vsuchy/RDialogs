require 'English'
require 'shellwords'
require 'rdialogs/version'

# A ruby wrapper for ncurses dialog and newt whiptail.
class RDialogs
  SUPPORTED_TOOLS = %w[dialog whiptail].freeze

  DEFAULT_DIALOG_SIZE = {
    width: 50,
    height: 10
  }.freeze

  DIALOGS_TABLE = [
    { name: 'info_box',     arg_name: 'infobox',     params: %i[text]               },
    { name: 'message_box',  arg_name: 'msgbox',      params: %i[text]               },
    { name: 'yesno_box',    arg_name: 'yesno',       params: %i[text]               },
    { name: 'input_box',    arg_name: 'inputbox',    params: %i[text default_value] },
    { name: 'password_box', arg_name: 'passwordbox', params: %i[text default_value] },
    { name: 'menu',         arg_name: 'menu',        params: %i[text list]          },
    { name: 'check_list',   arg_name: 'checklist',   params: %i[text list]          },
    { name: 'radio_list',   arg_name: 'radiolist',   params: %i[text list]          }
  ].freeze

  COMMON_OPTIONS_TABLE = [
    { name: 'title',         arg_name: 'title',         has_value: true  },
    { name: 'back_title',    arg_name: 'backtitle',     has_value: true  },

    { name: 'yes_button',    arg_name: 'yes-button',    has_value: true  },
    { name: 'no_button',     arg_name: 'no-button',     has_value: true  },
    { name: 'ok_button',     arg_name: 'ok-button',     has_value: true  },
    { name: 'cancel_button', arg_name: 'cancel-button', has_value: true  },
    { name: 'default_no',    arg_name: 'defaultno',     has_value: false },
    { name: 'no_cancel',     arg_name: 'nocancel',      has_value: false },

    { name: 'default_item',  arg_name: 'default-item',  has_value: true  },
    { name: 'no_item',       arg_name: 'noitem',        has_value: false },
    { name: 'no_tags',       arg_name: 'notags',        has_value: false },

    { name: 'clear',         arg_name: 'clear',         has_value: false },
    { name: 'full_buttons',  arg_name: 'fb',            has_value: false },
    { name: 'scroll_text',   arg_name: 'scrolltext',    has_value: false },
    { name: 'top_left',      arg_name: 'topleft',       has_value: false }
  ].freeze

  def initialize(dialog_cmd = 'dialog')
    raise "#{dialog_cmd}: command not supported" unless SUPPORTED_TOOLS.include?(File.basename(dialog_cmd))
    raise "#{dialog_cmd}: command not found" unless command_exists?(dialog_cmd)

    @dialog_cmd = dialog_cmd
  end

  DIALOGS_TABLE.each do |dialog|
    define_method(dialog[:name]) do |*args|
      cmd_run(build_cmd_args(dialog, args))
    end
  end

  private

  def command_exists?(cmd)
    ENV['PATH'].split(File::PATH_SEPARATOR).any? do |path|
      File.executable?(File.join(path, cmd))
    end
  end

  def dialog_size(options)
    width = options[:width] || DEFAULT_DIALOG_SIZE[:width]
    height = options[:height] || DEFAULT_DIALOG_SIZE[:height]

    { width: width, height: height }
  end

  def process_text(text)
    text.shellescape
  end

  def process_default_value(dialog, default_value)
    dialog[:params].include?(:default_value) && default_value ? default_value.shellescape : nil
  end

  def process_list_values(dialog, list)
    return unless dialog[:params].include?(:list)

    list.map do |k, v|
      if v.class == Array
        "#{k.to_s.shellescape} #{v[0].shellescape} #{v[1] ? 'ON' : 'OFF'}"
      else
        "#{k.to_s.shellescape} #{v.shellescape}"
      end
    end.join(' ')
  end

  def process_sizes(options, list_count)
    dialog_size = dialog_size(options)

    if list_count
      list_height = list_count < dialog_size[:height] - 8 ? list_count : dialog_size[:height] - 8

      "#{dialog_size[:height]} #{dialog_size[:width]} #{list_height}"
    else
      "#{dialog_size[:height]} #{dialog_size[:width]}"
    end
  end

  def process_common_options(options)
    out = options.map do |k, v|
      option = COMMON_OPTIONS_TABLE.detect { |x| x[:name] == k.to_s }

      unless option.nil?
        option[:has_value] ? "--#{option[:arg_name]} #{v.shellescape}" : "--#{option[:arg_name]}"
      end
    end

    out.join(' ').strip
  end

  def build_cmd_args(dialog, params)
    options = params.size > dialog[:params].size ? params.last : {}

    text = process_text(params.first)
    default_value = process_default_value(dialog, params[1])
    list_values = process_list_values(dialog, params[1])

    sizes = process_sizes(options, list_values ? params[1].size : nil)
    common_options = process_common_options(options)

    "#{common_options} --#{dialog[:arg_name]} #{text} #{sizes} #{default_value || list_values}".strip
  end

  def cmd_run(cmd_args)
    output = `#{@dialog_cmd} #{cmd_args} 3>&1 1>&2 2>&3`

    $CHILD_STATUS.success? ? output : false
  end
end
