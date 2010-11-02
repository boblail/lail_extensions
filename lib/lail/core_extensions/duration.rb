# module ActiveSupport
#   class Duration
#     
#     alias :from   :since
#     alias :after  :since
#     alias :before :ago
#     
#   end
# end

module DurationExtensions
  
  def from(*args)
    since(*args)
  end
  
  def after(*args)
    since(*args)
  end
  
  def before(*args)
    ago(*args)
  end

end

ActiveSupport::Duration.send(:include, DurationExtensions)
