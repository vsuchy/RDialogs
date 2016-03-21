require 'test_helper'

class RDialogsTest < Minitest::Test

  def setup
    @dialog = RDialogs.new('whiptail')
  end

  def test_that_it_has_a_version_number
    refute_nil ::RDialogs::VERSION
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
end
