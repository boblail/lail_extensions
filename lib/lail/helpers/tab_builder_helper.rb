module Lail
  module Helpers
    module TabBuilderHelper
      
      
      
      def tab_control_for(verb, options={}, &block)
        concat "<div class=\"tab-control\">"
        tabs_for(verb, options, &block)
        concat "<div class=\"tab-body\">"
        concat render :partial => selected_tab(verb)
        concat "</div>"
        concat "</div>"
      end
      
      
      
      def tabs_for(verb, options={}, &block)
        unless url=options[:url]
          url = @controller.request.request_uri
          url = url.split("?").first if url.index("?")
        end
        current_mode = selected_tab(verb) || options[:default]
        separator = options[:separator] || "" #"&nbsp;&nbsp;|&nbsp;&nbsp;"
        
        concat "<ul class=\"tabs\">"
          t = TabBuilder.new(self, url, verb, current_mode, options)
          yield t
          concat t.tabs.join(separator)
        concat "</ul>"
      end
      
      
      
    private
      
      
      
      def selected_tab(verb)
        params[verb]
      end
      
      
      
    end
  end
end