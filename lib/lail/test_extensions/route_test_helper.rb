require 'lail/route_permutater'

module RouteCollectionPermutater
  
  
  
  def each_possible_path_with(path_parameters, &block)
    each do |route|
      route.each_possible_path_with(path_parameters, &block)
    end
  end
  
  
  
end



module RouteTestHelper
  
  
  
  def routes
    @routes ||= begin
      routes = ActionController::Routing::Routes.routes
      routes.extend(RouteCollectionPermutater)
      routes
    end
  end
  
  
  
  def dynamic_routes
    @dynamic_routes ||= begin
      dynamic_routes = routes.select {|route| !route.segment_keys.empty?}
      dynamic_routes.extend(RouteCollectionPermutater)
      dynamic_routes
    end
  end
  
  
  
  def glob(path)
    path.split('/').reject(&:empty?)
  end
  
  
  
end