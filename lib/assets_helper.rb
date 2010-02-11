module AssetsHelper 
  
  
  def include_stylesheet_dir( path, options={} )
    css_path = options[:path] || "stylesheets"
    stylesheets = Dir.glob_in(File.join(RAILS_ROOT, "public", css_path, path), "*.css").map{|file| File.join("/css", path, file)}
    stylesheet_link_tag *stylesheets, :cache => true
  end


  def include_javascript_dir( path, options={} )
    js_path = options[:path] || "javascripts"
    javascripts = Dir.glob_in(File.join(RAILS_ROOT, "public", js_path, path), "*.js").map{|file| File.join("/js", path, file)}
    javascript_include_tag *javascripts, :cache => true
  end


end 


class Dir

  def Dir.glob_in(path, *args)
    original_dir = Dir.pwd
    begin
      Dir.chdir(path)
      return Dir.glob(*args)
    ensure
      Dir.chdir(original_dir)
    end
  end

end