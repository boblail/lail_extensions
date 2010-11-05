require 'settings_machine/base'

module SettingsMachine
  
  
  
  def has_settings(attribute, klass)
    raise "#{klass} must be a subclass of #{SettingsMachine::Base}" unless klass.ancestors.member?(SettingsMachine::Base)
    if ancestors.member?(ActiveRecord::Base)
      serialize attribute, Hash
      define_method(attribute) do
        ivar = "@#{attribute}"
        instance_variable_get(ivar) || instance_variable_set(ivar, klass.new(self, attribute, (self[attribute] ||= {})))
      end
    elsif ancestors.member?(SettingsMachine::Base)
      fields.push(attribute)
      define_method(attribute) do
        ivar = "@#{attribute}"
        instance_variable_get(ivar) || instance_variable_set(ivar, klass.new(@record, @original_attribute, (self[attribute] ||= {})))
      end
    else
      raise "expected to call has_settings only on ActiveRecord::Base or SettingsMachine::Base"
    end
    define_method("#{attribute}=") do
      raise "this field cannot be set through a setter"
    end
  end
  
  
  
end