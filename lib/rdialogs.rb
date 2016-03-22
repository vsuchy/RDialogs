require 'rdialogs/version'

# A ruby wrapper for ncurses dialog and newt whiptail.
class RDialogs
  SUPPORTED_TOOLS = ['dialog', 'whiptail']

  DEFAULT_DIALOG_SIZE = {
    width: 50,
    height: 10
  }

  DIALOGS_TABLE = [
    { name: 'info_box',     arg_name: 'infobox',     params: [:text] },
    { name: 'message_box',  arg_name: 'msgbox',      params: [:text] },
    { name: 'yesno_box',    arg_name: 'yesno',       params: [:text] },
    { name: 'input_box',    arg_name: 'inputbox',    params: [:text, :default_value] },
    { name: 'password_box', arg_name: 'passwordbox', params: [:text, :default_value] }
  ]

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
  ]

  def initialize(dialog_cmd = 'dialog')
    unless SUPPORTED_TOOLS.include?(File.basename(dialog_cmd))
      raise "#{dialog_cmd}: command not supported"
    end

    unless command_exists?(dialog_cmd)
      raise "#{dialog_cmd}: command not found"
    end

    @dialog_cmd = dialog_cmd
  end

  DIALOGS_TABLE.each do |dialog|
    define_method(dialog[:name]) do |*args|
      cmd_run(build_cmd_args(dialog, args))
    end
  end

  private

    def command_exists?(cmd)
      system("which #{cmd} > /dev/null")
    end

    def dialog_size(options)
      width = options[:width] || DEFAULT_DIALOG_SIZE[:width]
      height = options[:height] || DEFAULT_DIALOG_SIZE[:height]

      "#{height} #{width}"
    end

    def parse_params(options)
      out = options.map do |k, v|
        option = COMMON_OPTIONS_TABLE.detect { |x| x[:name] == k.to_s }

        unless option.nil?
          option[:has_value] ? "--#{option[:arg_name]} \"#{v}\"" : "--#{option[:arg_name]}"
        end
      end

      out.join(' ').strip
    end

    def build_cmd_args(dialog, params)
      text = params[0]
      default_value = "\"#{params[1]}\"" if dialog[:params].include?(:default_value)
      options = params.size > dialog[:params].size ? params.last : {}

      "#{parse_params(options)} --#{dialog[:arg_name]} \"#{text}\" #{dialog_size(options)} #{default_value}".strip
    end

    def cmd_run(cmd_args)
      output = `#{@dialog_cmd} #{cmd_args} 3>&1 1>&2 2>&3`

      { output: output, status: $? == 0 }
    end
end
