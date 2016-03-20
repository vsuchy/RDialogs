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
    full_buttons:  { arg: '--fb',            has_value: false }
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

  def message_box(text, args = {})
    dialog_run("#{parse_args(args)} --msgbox \"#{text}\" #{box_size(args)}")
  end

  def yesno_box(text, args = {})
    dialog_run("#{parse_args(args)} --yesno \"#{text}\" #{box_size(args)}")
  end

  def input_box(text, args = {})
    dialog_run("#{parse_args(args)} --inputbox \"#{text}\" #{box_size(args)}")
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

    def dialog_run(args)
      output = `#{@dialog_cmd} #{args} 3>&1 1>&2 2>&3`

      { output: output, status: $? == 0 }
    end
end
