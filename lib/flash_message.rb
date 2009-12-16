module FlashMessage

  def flash_message(key, options={})
    message = flash[key] || ""
    options.reverse_merge!(:class => "flash #{key}", :id => "flash_#{key}")
    options.merge!(:style => "display:none;") if message.empty?
    content_tag :div, message, options
  end
  
end