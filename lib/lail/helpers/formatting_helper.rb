module Lail
  module Helpers
    module FormattingHelper
      include ActionView::Helpers::TagHelper
      
      
      
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
        if object and object.respond_to?("errors") and !(messages = object.errors.all_messages).empty?
          s = "<ul>#{messages.collect{|msg| content_tag(:li, msg)}.join}</ul>"
          s.respond_to?(:html_safe) ? s.html_safe : s
        else
          ""
        end
      end
      
      
      
    end
  end
end