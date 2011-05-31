module Lail
  module Helpers
    class TabBuilder
      attr_reader :tabs
      
      
      
      def initialize(template, url, verb, current_mode, options)
        @template, @url, @verb, @current_mode, @options = template, url, verb, current_mode, options
        @tabs = []
      end
      
      
      
      def make(text, mode=nil)
        tab = "<span class=\"tab-left\"></span><span class=\"tab-middle\">#{text}</span><span class=\"tab-right\"></span>"
        mode ||= text.underscore.downcase
        id = "tab_#{mode.to_s.underscore}"
        
        css = ["tab"]
        css << @options[:tab_class] if @options[:tab_class]
        if (mode==@current_mode)
          css << "current"
        else
          params = (@options[:params]||{}).merge(@verb => mode)
          parameters_string = params.map{|k,v| v.blank? ? nil : "#{k}=#{URI.escape(v)}"}.compact.join("&")
          parameters_string = "?#{parameters_string}" unless parameters_string.blank?
          url = @url + parameters_string
          tab = "<a href=\"#{url}#tabs\">#{tab}</a>"
        end
        tabs << "<li id=\"#{id}\" class=\"#{css.join(" ")}\">#{tab}</li>"
        nil
      end
      
      
      
    end
  end
end