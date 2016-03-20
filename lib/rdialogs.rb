require 'rdialogs/version'

class RDialogs
  SUPPORTED_TOOLS = ['dialog', 'whiptail']

  ARGS_TABLE = {
    title:         { arg: '--title',         has_value: true  },
    back_title:    { arg: '--backtitle',     has_value: true  },

    yes_button:    { arg: '--yes-button',    has_value: true  },
    no_button:     { arg: '--no-button',     has_value: true  },
    ok_button:     { arg: '--ok-button',     has_value: true  },
    cancel_button: { arg: '--cancel-button', has_value: true  },
    default_no:    { arg: '--defaultno',     has_value: false },
    no_cancel:     { arg: '--nocancel',      has_value: false },

    default_item:  { arg: '--default-item',  has_value: true  },
    no_item:       { arg: '--noitem',        has_value: false },
    no_tags:       { arg: '--notags',        has_value: false },

    clear:         { arg: '--clear',         has_value: false },
    full_buttons:  { arg: '--fb',            has_value: false },
    scroll_text:   { arg: '--scrolltext',    has_value: false },
    top_left:      { arg: '--topleft',       has_value: false }
  }

  ARGS_DEFAULT = {
    width: 50,
    height: 10
  }

  def initialize(dialog_cmd = 'dialog')
    unless command_exists?(dialog_cmd)
      raise "#{dialog_cmd}: command not found"
    end

    unless SUPPORTED_TOOLS.include?(File.basename(dialog_cmd))
      raise "#{dialog_cmd}: command not supported"
    end

    @dialog_cmd = dialog_cmd
  end

  def info_box(text, args = {})
    dialog_run(build_cmd_args('infobox', text, args))
  end

  def message_box(text, args = {})
    dialog_run(build_cmd_args('msgbox', text, args))
  end

  def yesno_box(text, args = {})
    dialog_run(build_cmd_args('yesno', text, args))
  end

  def input_box(text, args = {}, default_value = '')
    dialog_run(build_cmd_args('inputbox', text, args) + " #{default_value}")
  end

  def password_box(text, args = {}, default_value = '')
    dialog_run(build_cmd_args('passwordbox', text, args) + " #{default_value}")
  end

  private

    def command_exists?(cmd)
      system("which #{cmd} > /dev/null")
    end

    def box_size(args)
      width = args[:width] || ARGS_DEFAULT[:width]
      height = args[:height] || ARGS_DEFAULT[:height]

      "#{height} #{width}"
    end

    def parse_args(args)
      out = args.map do |k,v|
        next if k == :width || k == :height
        ARGS_TABLE[k][:has_value] ? "#{ARGS_TABLE[k][:arg]} \"#{v}\"" : ARGS_TABLE[k][:arg]
      end

      out.join(' ').strip
    end

    def build_cmd_args(box_type, text, args)
      "#{parse_args(args)} --#{box_type} \"#{text}\" #{box_size(args)}"
    end

    def dialog_run(args)
      output = `#{@dialog_cmd} #{args} 3>&1 1>&2 2>&3`

      { output: output, status: $? == 0 }
    end
end
