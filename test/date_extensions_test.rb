require 'test_helper'
require 'lail/core_extensions/date'

class DateExtensionsTest < ActiveSupport::TestCase
  
  
  
  test "whole months between 1/1 and 1/25 should be 0" do
    assert_equal 0, Date.new(2010, 1, 25).whole_months_since(Date.new(2010, 1, 1))
  end
  
  
  
  test "whole months between 1/2 and 1/25 should be 0" do
    assert_equal 0, Date.new(2010, 1, 25).whole_months_since(Date.new(2010, 1, 2))
  end
  
  
  
  test "whole months between 1/1 and 2/1 should be 1" do
    assert_equal 1, Date.new(2010, 2, 1).whole_months_since(Date.new(2010, 1, 1))
  end
  
  
  
  test "whole months between 1/1 and 3/13 should be 2" do
    assert_equal 2, Date.new(2010, 3, 13).whole_months_since(Date.new(2010, 1, 1))
  end
  
  
  
  test "whole months between 1/1 and 12/31 should be 12" do
    assert_equal 12, Date.new(2010, 12, 31).whole_months_since(Date.new(2010, 1, 1))
  end
  
  
  
  test "should be able to parse '2010-04-15' as a date" do
    assert_equal true, Date.can_parse?('2010-04-15')
  end
  
  
  
  test "should not be able to parse a date with invalid numbers" do
    assert_nothing_raised do
      assert_equal false, Date.can_parse?('2010-0-15')
    end
  end
  
  
  
  test "should not be able to parse a bunch of letters as a date" do
    assert_nothing_raised do
      assert_equal false, Date.can_parse?('adfadsfs')
    end
  end
  
  
  
end