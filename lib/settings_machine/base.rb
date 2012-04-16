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
    
    
    
    def initialize(parent, original_attribute, settings)
      @parent, @original_attribute, @settings = parent, original_attribute, settings
    end
    
    attr_reader :parent, :original_attribute
    
    
    
    def to_hash
      fields.inject({}) {|hash, field| hash.merge(field => send(field)) }
    end
    
    
    
    def [](key)
      raise(ArgumentError, "#{key} is not a field of #{self.class}") unless fields.member?(key)
      @settings[key]
    end
    
    def []=(key, value)
      raise(ArgumentError, "#{key} is not a field of #{self.class}") unless fields.member?(key)
      if value.nil?
        @settings.delete(key) # so we're not serializing nil (e.g. as a Syck::PrivateType)
      else
        @settings[key] = value
      end
      touch
    end
    
    def merge!(hash)
      (hash ||= {}).pick(fields).each do |key, value|
        self.send("#{key}=", value)
      end
    end
    
    
    
  protected
    
    
    
    def record
      record = parent
      while record.is_a?(SettingsMachine::Base)
        record = record.parent
      end
      record
    end
    
    
    
    def touch
      if(parent == record)
        parent.try("#{@original_attribute}_will_change!".to_sym)
      else
        parent.touch
      end
    end
    
    
    
    def save
      record.save(:validate => false) # !nb: is this a good idea?
    end
    
    
    
    def i_or_nil(string)
      string.blank? ? nil : string.to_i
    end
    
    def to_bool(string, options={})
      case string
      when TrueClass, FalseClass
        string
      when String
        string.blank? ? to_bool(nil, options) : %w{true 1}.member?(string)
      else
        options[:default] || false
      end
    end
    
    def date_or_nil(string)
      begin
        Date.parse(string)
      rescue
        nil
      end
    end
    
    
    
  end
end