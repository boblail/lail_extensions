module HashExtensions


  def pick(*keys)
    result = {}
    keys.each {|key| result[key] = self[key] if self.key?(key)}
    result
  end


end


Hash.send :include, HashExtensions