module SettingsMachine
  class Base
    extend SettingsMachine
    
    
    
    def self.has_fields(*has_fields)
      has_fields = has_fields.first if has_fields.first.is_a?(Array)
      fields.push(*has_fields)
      fields.each do |field|
        define_method(field) {self[field]}
        define_method("#{field}=") {|value| self[field] = value}
      end
    end
    
    def self.fields
      @recognized_fields ||= []
    end
    
    def fields
      self.class.fields
    end
    
    
    
    def initialize(record, original_attribute, settings)
      @record, @original_attribute, @settings = record, original_attribute, settings
    end
    
    
    
    def [](key)
      raise(ArgumentError, "#{key} is not a field of #{self.class}") unless fields.member?(key)
      @settings[key]
    end
    
    def []=(key, value)
      raise(ArgumentError, "#{key} is not a field of #{self.class}") unless fields.member?(key)
      @settings[key] = value
      touch
    end
    
    def merge!(hash={})
      hash.pick(fields).each do |key, value|
        self[key] = value
      end
    end
    
    
    
  protected
    
    
    
    def touch
      @record.send("#{@original_attribute}_will_change!")
    end
    
    
    
    def save
      @record.save
    end
    
    
    
    def i_or_nil(string)
      string.blank? ? nil : string.to_i
    end
    
    def to_bool(string, options={})
      string.blank? ? (options[:default] || false) : %w{true 1}.member?(string)
    end
    
    
    
  end
end