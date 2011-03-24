require 'test_helper'
require 'lail/core_extensions/time'

class TimeExtensionsTest < ActiveSupport::TestCase
  
  
  
  test "Time.ceil should round up" do
    assert_equal Time.mktime(2010,1,1,6,30), Time.mktime(2010,1,1,6,01).ceil(30.minutes)
    assert_equal Time.mktime(2010,1,1,6,30), Time.mktime(2010,1,1,6,29).ceil(30.minutes)
    assert_equal Time.mktime(2010,1,1,6,30), Time.mktime(2010,1,1,6,30).ceil(30.minutes)
  end
  
  
  
end