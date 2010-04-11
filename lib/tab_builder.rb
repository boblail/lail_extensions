class TabBuilder
  attr_reader :tabs
  
  def initialize(template, url, verb, current_mode, options)
    @template, @url, @verb, @current_mode = template, url, verb, current_mode
    @tabs = []
  end
  
  def make(text, mode=nil)
    tab = "<div class=\"tab-left\"></div><div class=\"tab-middle\">#{text}</div><div class=\"tab-right\"></div>"
    if (mode==@current_mode)
      tabs << "<li class=\"tab current\">#{tab}</li>"
    else
      url = mode ? "#{@url}?#{@verb}=#{URI.escape mode}" : @url
      tabs << "<li class=\"tab\"><a href=\"#{url}#tabs\">#{tab}</a></li>"
    end
  end
end
  
class ActionView::Base
  
  def tab_control_for(verb, options={}, &block)
    concat "<div class=\"tab-control\">"
    tabs_for(verb, options, &block)
    concat "<div class=\"tab-body\">"
    concat render :partial => instance_variable_get("@#{verb}")
    concat "</div>"
    concat "</div>"
  end
  
  def tabs_for(verb, options={}, &block)
    unless url=options[:url]
      url = @controller.request.request_uri
      url = url.split("?").first if url.index("?")
    end
    current_mode = params[verb] || options[:default]
    separator = options[:separator] || "" #"&nbsp;&nbsp;|&nbsp;&nbsp;"
      
    concat "<ul id=\"tabs\" class=\"tabs\">"
      t = TabBuilder.new(self, url, verb, current_mode, options)
      yield t
      concat t.tabs.join(separator)
    concat "</ul>"
  end
  
end