module Lail
  module ActionPackExtensions
    module FlashMessageUpdater
      
      
      
      def update_flash_message(key, options={})
        id, message = "flash_#{key}", flash[key]
        if message
          replace_html(id, message)
          show(id)
        else
          hide(id)
        end
      end
      
      
      
      def update_flash_messages(*args)
        args = [:notice, :error] if args.empty?
        args.each do |key|
          update_flash_message(key)
        end
      end
      
      
      
      def flash
        @context.flash
      end
      
      
      
    end
  end
end
