require 'test_helper'

class RDialogsTest < Minitest::Test
  def setup
    @dialog = RDialogs.new('whiptail')
    @cmd_run = ->(args) { args }
  end

  def test_that_it_has_a_version_number
    refute_nil RDialogs::VERSION
  end

  def test_that_it_fails_to_initialize_with_unsupported_tool
    exception = assert_raises(RuntimeError) { RDialogs.new('CocoaDialog') }
    assert_equal exception.message, 'CocoaDialog: command not supported'
  end

  def test_that_it_initialize_with_supported_tool
    assert_equal @dialog.instance_variable_get(:@dialog_cmd), 'whiptail'
  end

  def test_that_command_exists
    assert @dialog.send(:command_exists?, 'ruby')
    refute @dialog.send(:command_exists?, 'xxxx')
  end

  def test_that_info_box_runs_with_correct_arguments
    @dialog.stub(:cmd_run, @cmd_run) do
      cmd_args = @dialog.info_box(
        'Hello test.',
        width: 70,
        height: 20,
        full_buttons: true
      )

      assert_equal cmd_args, '--fb --infobox "Hello test." 20 70'
    end
  end

  def test_that_input_box_runs_with_correct_arguments
    @dialog.stub(:cmd_run, @cmd_run) do
      cmd_args = @dialog.input_box(
        'Your name?',
        'Vlad',
        ok_button: 'OK :)',
        full_buttons: true
      )

      assert_equal cmd_args, '--ok-button "OK :)" --fb --inputbox "Your name?" 10 50 "Vlad"'
    end
  end
end
