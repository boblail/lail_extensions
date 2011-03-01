module Enumerable
  
  
  
  def except(*args)
    self.reject {|i| args.member?(i)}
  end
  
  
  
  def car
    first
  end
  
  def cdr
    self[1..-1]
  end
  
  
  
  def collect_with_index
    new_array = []
    if block_given?
      each_with_index {|item, index| new_array <<  yield(item, index)}
    else
      each_with_index {|item, index| new_array <<  [item, index]}
    end
    new_array
  end
  alias :map_with_index :collect_with_index
  
  
  # This is in ActiveSupport::CoreExtensions::Array::Grouping now
  # def in_groups(n)
  #   length = self.length
  #   group_size = (Float(length)/n).ceil
  #   groups = []
  #   (0...n).each do |i|
  #     groups << (self[(i*group_size)...((i+1)*group_size)] || [])
  #   end
  #   groups
  # end
  
  
  
end