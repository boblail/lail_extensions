class TabBuilder
  attr_reader :tabs
  
  def initialize(template, url, verb, current_mode, options)
    @template, @url, @verb, @current_mode = template, url, verb, current_mode
    @tabs = []
  end
  
  def make(text, mode=nil)
    if (mode==@current_mode)
      tabs << "<li class=\"current\"><div class=\"left\"></div><div class=\"middle\">#{text}</div><div class=\"right\"></div></li>"
    else
      url = mode ? "#{@url}?#{@verb}=#{URI.escape mode}" : @url
      tabs << "<li><a href=\"#{url}\">#{text}</a></li>"
    end
  end  
end
  
class ActionView::Base
  
  def tabs_for(verb, options={})
    unless url=options[:url]
      url = @controller.request.request_uri
      url = url.split("?").first if url.index("?")
    end
    current_mode = params[verb] || options[:default]
    separator = options[:separator] || "" #"&nbsp;&nbsp;|&nbsp;&nbsp;"
      
    concat "<ul class=\"tabs\">"
      t = TabBuilder.new(self, url, verb, current_mode, options)
      yield t
      concat t.tabs.join(separator)
    concat "</ul>"
  end
  
end