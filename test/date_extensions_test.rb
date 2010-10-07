require 'test_helper'
require 'date_extensions'

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
  
  
  
end