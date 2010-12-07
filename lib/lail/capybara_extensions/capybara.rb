require 'capybara'

module Capybara
  
  
  
  def with_driver(value, &block)
    _driver = Capybara.current_driver
    begin
      logout
      Capybara.current_driver = value
      yield
    ensure
      Capybara.current_driver = _driver
    end
  end
  
  
  
end