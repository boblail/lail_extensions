module Lail
  module Helpers
    module FlashMessageHelper
      
      
      
      def flash_message(key, options={})
        message = (flash[key] || "").to_s
        options.reverse_merge!(:class => "flash #{key}", :id => "flash_#{key}")
        options.merge!(:style => "display:none;") if message.empty?
        content_tag :div, message, options
      end
      
      
      
    end
  end
end
