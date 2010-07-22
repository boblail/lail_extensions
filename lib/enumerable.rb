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


end