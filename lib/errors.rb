module ErrorsExtensions

  def print
    self.map {|h,k| "#{h} #{k}"}
  end
  
  def all_messages
    all_messages = []
    self.each do |attribute, messages|
      begin
        messages = [messages] unless messages.is_a?(Array)
        if attribute == "base"
          all_messages.concat(messages)
        elsif @base.respond_to?(attribute) and
              (value = @base.send(attribute)).respond_to?(:errors) and
              value.errors.respond_to?(:all_messages)
              (value_messages = value.errors.all_messages).any?
          all_messages.concat(value_messages.collect{|m| "#{attribute.to_s.humanize}: #{m}"})
        else
          all_messages.concat(messages.collect{|m| "#{attribute.to_s.humanize} #{m}"})
        end
      rescue
        # First, don't explode when we're trying to collect error messages
        debugger
      end
    end
    all_messages
  end

  def full_messages_recursive
    lines = []
    depth = 0
    print_array = lambda do |array|
      depth += 1
      for i in array
        if i.is_a?(String) # or i.is_a?(ActiveRecord::Error)
          lines << "#{"  " * depth}#{i}"
        elsif i.is_a?(Array)
          print_array.call(i)
        else 
          lines << "#{"  " * depth}#{i.class.name}"
        end
      end
      depth -= 1
    end
    print_array.call(all_messages)
    lines
  end

=begin
  def full_messages_recursive
    full_messages = []
    @errors.each_key do |attribute|
      attr_name = @base.class.human_attribute_name(attribute)
      if (attribute != "base") and
         @base.respond_to?(attribute) and
         (value = @base.send(attribute)).respond_to?("errors")
        full_messages.concat value.errors.full_messages_recursive.map {|msg| "#{attr_name}: #{msg}"}
      else
        @errors[attribute].each do |message|
          next unless message
          if attribute == "base"
            full_messages << message
          else
            full_messages << "#{attr_name} #{message}"
          end
        end
      end
    end
    full_messages
  end
=end

end


ActiveRecord::Errors.send(:include, ErrorsExtensions) if defined?(ActiveRecord::Errors)
ActiveModel::Errors.send(:include, ErrorsExtensions) if defined?(ActiveModel::Errors)