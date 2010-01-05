module HashExtensions


  def pick(*picks)
    result = {}
    picks.each {|key| result[key] = self[key] if self.key?(key)}
    result
  end
  
  def pick!(*picks)
    keys.each {|key| self.delete(key) unless picks.member?(key) }
  end


end


Hash.send :include, HashExtensions