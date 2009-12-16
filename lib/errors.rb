class ActiveRecord::Errors

  def print
    self.map {|h,k| "#{h} #{k}"}
  end

end