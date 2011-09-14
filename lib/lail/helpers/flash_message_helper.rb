module Lail
  module Helpers
    module FlashMessageHelper
      
      
      def flash_messages(*args)
        options = args.extract_options!
        args.inject("") {|html, key| html << flash_message(key, options.dup)}.html_safe
      end
      
      
      def flash_message(key, options={})
        message = flash[key].to_s
        options.reverse_merge!(:class => "flash #{key}", :id => "flash_#{key}")
        options.merge!(:style => "display:none;") if message.empty?
        content_tag :div, message, options
      end
      
      
    end
  end
end
