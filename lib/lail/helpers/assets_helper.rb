require 'lail/core_extensions/dir'

module Lail
  module Helpers
    module AssetsHelper
      
      
      
      def include_stylesheet_dir(path, options={})
        stylesheets = get_assets_in_path(path, (options[:path] || 'stylesheets'), 'css', options)
        cache_name = get_cache_name(path)
        stylesheets.delete(cache_name + '.css')
        stylesheet_link_tag *(stylesheets + [{:cache => cache_name}.merge(options.pick(:media))])
      end
      
      
      
      def include_javascript_dir(path, options={})
        javascripts = get_assets_in_path(path, (options[:path] || 'javascripts'), 'js', options)
        cache_name = get_cache_name(path)
        javascripts.delete(cache_name + '.js')
        javascript_include_tag *(javascripts + [{:cache => cache_name}])
      end
      
      
      
    private
      
      
      
      def get_assets_in_path(path, relative_path, extension, options)
        directory = get_asset_directory(relative_path, path)
        assets    = Dir.glob_in(directory, "*.#{extension}")
        assets    = apply_order(assets, (options[:order] || []).map{|s| "#{s}.#{extension}"})
                    assets.map{|file| File.join(path, file)}
      end
      
      
      
      def get_asset_directory(relative_path, path)
        path_parts = [Rails.root, 'public']
        path_parts << relative_path unless path.start_with?('/')
        path_parts << path
        File.join(*path_parts)
      end
      
      
      
      def apply_order(assets, order)
        order.empty? ? assets : ((order & assets) + (assets - order))
      end
      
      
      
      def get_cache_name(path)
        "#{path}/#{File.basename(path)}.min"
      end
      
      
      
    end
  end 
end
