module Slug
  ValidSlug = begin
  	# must start with a letter
    # must be at least one character long
	  # may include only lowercase latin letters, numbers, dashes, and underscores
	  /\A[a-z][a-z0-9_-]*\z/
  end
  ValidSegment = begin
    # must start with a letter
    # must be at least one character long
    # may include only lowercase latin letters, numbers, dashes, and underscores
    /[a-z][a-z0-9_-]*/
  end
end

module ToSlug
  
  # Generate a slug for the string +value+.
  #
  # A slug should consist of numbers (0-9), lowercase letters (a-z) and 
  # dashes (-). Any other characters should be filtered.
  #
  # ==== Example
  #
  #   "The World is Beautiful!".to_slug # => "the-world-is-beautiful"
  #
  # ==== Returns
  # String:: A 'sluggified' version of this string
  #
  # --
  # @api public
  def to_slug
    # Perform transliteration to replace non-ascii characters with an ascii
    # character    
    # value = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    # works for Ruby 1.9.1
    value = self.encode("ascii")
    
    # Remove single quotes from input
    value.gsub!(/[']+/, '')

    # Replace any non-word character (\W) with a space
    value.gsub!(/\W+/, ' ')
    
    # Remove any whitespace before and after the string
    value.strip!
    
    # All characters should be downcased
    value.downcase!
    
    # Replace spaces with dashes
    value.gsub!(' ', '-')
    
    # Return the resulting slug
    value
  end
  
end