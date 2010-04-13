module RoutePermutater
  
  #
  # This function creates an array of all URLs which are permutations of the test values.
  #
  # path_parameters can either be an array or a hash
  #   if an array, each option in path_parameters will be plugged into each segment
  #   if a hash, the key names the segment and the value is an array of options to be
  #     plugged into that segment
  #
  def generate_permutations(path_parameters)
    
    #
    # 1. generate an array of arrays: one array per segment
    #    with all the optional values for that segment
    #    a. some segments will be static and will contain an array of a single value
    #    b. some segments will be dynamic and will contain an array of possible values
    #
    segments_permutations = []
    self.segments.each do |segment|
      if segment.is_a? ActionController::Routing::DynamicSegment
        segments_permutations << (path_parameters.is_a?(Array) ? path_parameters : (path_parameters[segment.key]||[]))
      else
        segments_permutations << [segment.to_s]
      end
    end
    
    #
    # 2. create urls from all the permutations
    #
    generate_url_permutations_recursive([""], *segments_permutations)
  end


private


  def generate_url_permutations_recursive(permutations, *segments)
    return permutations if (segments.length==0)

    next_possibilities = segments.shift
    next_permutations = []
    for permutation in permutations
      for possibility in next_possibilities
        next_permutations << permutation + possibility.to_s
      end
    end

    generate_url_permutations_recursive(next_permutations, *segments)
  end

  
end


ActionController::Routing::Route.send :include, RoutePermutater