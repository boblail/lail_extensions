# encoding: UTF-8
require 'active_support/inflector'

module Slug
  
  ValidSlug = begin
    # must start with a letter or number
    # must be at least one character long
    # may include only lowercase latin letters, numbers, dashes, and underscores
    /\A[a-z0-9][a-z0-9_\-]*\z/
  end
  
  ValidSegment = begin
    # must start with a letter or number
    # must be at least one character long
    # may include only lowercase latin letters, numbers, dashes, and underscores
    /[a-z0-9][a-z0-9_\-]*/
  end
  
end


module ToSlug
  
  def to_slug
    gsub(/['‘’`“”"]/, '').parameterize
  end
  
end

String.send(:include, ToSlug)
