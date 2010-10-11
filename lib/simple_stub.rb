#
# SimpleStub
#
#   Very simple method stubbing for unit tests
#
#
module SimpleStub
  
  
  
  def stubbed_methods
    (@stubs || {}).keys
  end
  # alias :stubs :stubbed_methods
  
  
  
  def stub_method(method_name, &block)
    method_name = method_name.to_sym
    save_original_method(method_name)
    define_method(method_name, &block)
  end
  alias :stub :stub_method
  alias :stubs :stub_method
  
  
  
  def method_stubbed?(method_name)
    method_name = method_name.to_sym
    stubbed_methods.member?(method_name)
  end
  alias :stubbed? :method_stubbed?
  
  
  
  def restore_original_method(method_name)
    method_name = method_name.to_sym
    original_method = get_original_method(method_name)
    define_method(method_name, original_method) if original_method
  end
  alias :unstub :restore_original_method
  
  
  
private
  
  
  
  def save_original_method(method_name)
    (@stubs ||= {}).merge!(method_name => instance_method(method_name))
  end
  
  
  
  def get_original_method(method_name)
    (@stubs || {})[method_name]
  end
  
  
  
end



# Module.send(:include, SimpleStub)
Module.extend(SimpleStub)
Object.extend(SimpleStub)