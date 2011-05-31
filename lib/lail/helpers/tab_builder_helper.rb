module Lail
  module Helpers
    module TabBuilderHelper
      
      
      
      def tab_control_for(verb, options={}, &block)
        "<div class=\"tab-control\">".html_safe << 
          tabs_for(verb, options, &block) <<
          "<div class=\"tab-body\">".html_safe <<
            render(:partial => selected_tab(verb)) <<
          "</div>".html_safe <<
        "</div>".html_safe
      end
      
      
      
      def tabs_for(verb, options={}, &block)
        unless url=options[:url]
          url = request.url
          url = url.split("?").first if url.index("?")
        end
        current_mode = selected_tab(verb) || options[:default]
        separator = options[:separator] || "" #"&nbsp;&nbsp;|&nbsp;&nbsp;"
        
        t = TabBuilder.new(self, url, verb, current_mode, options)
        yield(t)
       ("<ul class=\"tabs\">" <<
          t.tabs.join << 
        "</ul>").html_safe
      end
      
      
      
    private
      
      
      
      def selected_tab(verb)
        params[verb]
      end
      
      
      
    end
  end
end