class ActiveRecord::Errors

  def print
    self.map {|h,k| "#{h} #{k}"}
  end

  def full_messages_recursive
    full_messages = []
    @errors.each_key do |attribute|
      @errors[attribute].each do |message|
        next unless message

        if attribute == "base"
          full_messages << message
        else
          attr_name = @base.class.human_attribute_name(attribute)
          if @base.repond_to?(attribute) and (value = object.send(attribute)).respond_to?("errors")
            full_messages.concat value.errors.full_messages_recursive.map {|msg| "#{attr_name}: #{msg}"}
          else
            full_messages << attr_name + I18n.t('activerecord.errors.format.separator', :default => ' ') + message
          end
        end
      end
    end
    full_messages
  end

end