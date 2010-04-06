module FormattingHelper

  def format_params( hash=params, level=0 )
    output = ""
    hash.map do |k,v|
      level.times do
        output << " "
      end
      if v.is_a? Hash
        output << "#{k}:\n"
        output << format_params(v, level + 2) if v.is_a? Hash
      elsif v.is_a? Array
        output << "#{k}=[#{v.join(",")}]\n"
      else
        output << "#{k}='#{v}'\n"
      end
    end
    output
  end

  def format_errors(object)    
    if object and
       object.respond_to?("errors") and
       #!(messages = object.errors.full_messages).empty?
      #"<ul>" + messages.collect {|msg| "<li>#{msg}</li>"}.join + "</ul>"
       !(messages = object.errors.full_messages).empty?
      "<ul>" + messages.collect {|msg| "<li>#{msg.is_a?(Array) ? msg.flatten(" - ") : msg}</li>"}.join + "</ul>"
    else
      ""
    end

=begin
    if object and object.respond_to? "errors"
      temp = "<ul>"
      object.errors.each do |k,v|
        temp << "<li>"
        temp << "<p>#{k.humanize} #{v}</p>"
        if object.respond_to? k
          value = object.send k
          temp << format_errors(value)
        end
        temp << "</li>"
      end
      temp << "</ul>"
    else
      ""
    end
=end
  end
  
end