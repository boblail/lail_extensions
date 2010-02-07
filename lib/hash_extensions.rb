module HashExtensions


  def pick(*picks)
    picks = picks.flatten
    picks.inject({}) {|result, key| self.key?(key) ? result.merge(key => self[key]) : result}
  end
  
  def pick!(*picks)
    picks = picks.flatten
    keys.each {|key| self.delete(key) unless picks.member?(key) }
  end


end


Hash.send :include, HashExtensions