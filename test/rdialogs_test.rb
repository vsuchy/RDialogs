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
    assert_equal 'CocoaDialog: command not supported', exception.message
  end

  def test_that_it_initialize_with_supported_tool
    assert_equal 'whiptail', @dialog.instance_variable_get(:@dialog_cmd)
  end

  def test_that_command_exists
    assert @dialog.send(:command_exists?, 'ruby')
    refute @dialog.send(:command_exists?, 'xxxx')
  end

  def test_that_info_box_runs_with_correct_arguments
    @dialog.stub(:cmd_run, @cmd_run) do
      cmd_args = @dialog.info_box('Test 123.', width: 70, height: 20, full_buttons: true)

      assert_equal "--fb --infobox #{'Test 123.'.shellescape} 20 70", cmd_args
    end
  end

  def test_that_input_box_runs_with_correct_arguments
    @dialog.stub(:cmd_run, @cmd_run) do
      cmd_args = @dialog.input_box("What's your name?", 'Vlad', full_buttons: true)

      assert_equal "--fb --inputbox #{"What's your name?".shellescape} 10 50 #{'Vlad'.shellescape}", cmd_args
    end
  end

  def test_that_menu_runs_with_correct_arguments
    @dialog.stub(:cmd_run, @cmd_run) do
      cmd_args = @dialog.menu('Colors', red: '25500', blue: '00255', green: '01280')

      assert_equal '--menu Colors 10 50 2 red 25500 blue 00255 green 01280', cmd_args
    end
  end

  def test_that_check_list_runs_with_correct_arguments
    @dialog.stub(:cmd_run, @cmd_run) do
      cmd_args = @dialog.menu('Colors', red: ['25500', false], blue: ['00255', true], green: ['01280', false])

      assert_equal '--menu Colors 10 50 2 red 25500 OFF blue 00255 ON green 01280 OFF', cmd_args
    end
  end
end
