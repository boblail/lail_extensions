require 'uri'

class Capybara::Session
  
  
  
  def current_path
    URI.parse(self.current_url).path
  end
  
  
  
end