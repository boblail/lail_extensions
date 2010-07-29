class TabBuilder
  attr_reader :tabs
  
  def initialize(template, url, verb, current_mode, options)
    @template, @url, @verb, @current_mode, @options = template, url, verb, current_mode, options
    @tabs = []
  end
  
  def make(text, mode=nil)
    tab = "<span class=\"tab-left\"></span><span class=\"tab-middle\">#{text}</span><span class=\"tab-right\"></span>"

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
    tabs << "<li class=\"#{css.join(" ")}\">#{tab}</li>"
  end
end
  
class ActionView::Base
  
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
      
    concat "<ul id=\"tabs\" class=\"tabs\">"
      t = TabBuilder.new(self, url, verb, current_mode, options)
      yield t
      concat t.tabs.join(separator)
    concat "</ul>"
  end
  
private

  def selected_tab(verb)
    # instance_variable_get("@#{verb}")
    params[verb]
  end
  
end