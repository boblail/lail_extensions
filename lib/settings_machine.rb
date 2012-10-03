require 'settings_machine/base'

module SettingsMachine
  
  
  
  def has_settings(attribute, klass)
    raise "#{klass} must be a subclass of #{SettingsMachine::Base}" unless klass.ancestors.member?(SettingsMachine::Base)
    
    if ancestors.member?(SettingsMachine::Base)
      fields.push(attribute)
    end
    
    if ancestors.member?(ActiveRecord::Base)
      serialize attribute
    end
    
    define_method(attribute) do
      ivar = "@__settings_machine_#{attribute}"
      instance_variable_get(ivar) || begin
        hash = self[attribute]
        self[attribute] = hash = {} unless hash.is_a?(Hash) && !hash.empty?
        instance_variable_set(ivar, klass.new(self, attribute, hash))
      end
    end
    
    define_method("#{attribute}=") do |value|
      send(attribute).merge!(value)
    end
  end
  
  
  
end