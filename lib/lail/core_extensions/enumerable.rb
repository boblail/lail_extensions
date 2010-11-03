module Enumerable
  
  
  
  def except(*args)
    self.reject {|i| args.member?(i)}
  end
  
  
  
  def collect_with_index(&block)
    new_array = []
    each_with_index do |item, index|
      new_array << yield(item, index)
    end
    new_array
  end
  
  
  def in_groups(n)
    length = self.length
    group_size = (Float(length)/n).ceil
    groups = []
    (0...n).each do |i|
      groups << (self[(i*group_size)...((i+1)*group_size)] || [])
    end
    groups
  end
  
  
  
end