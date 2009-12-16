module Enumerable


  def except(*args)
    self.reject {|i| args.member?(i)}
  end


end