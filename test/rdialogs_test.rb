require 'test_helper'

class RDialogsTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::RDialogs::VERSION
  end

  def test_that_it_only_accepts_supported_tools
    exception = assert_raises(RuntimeError) { RDialogs.new('CocoaDialog') }
    assert_equal 'CocoaDialog: command not supported', exception.message
  end
end
