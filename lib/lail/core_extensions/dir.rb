class Dir
  
  
  
  def Dir.glob_in(path, *args)
    original_dir = Dir.pwd
    begin
      Dir.chdir(path.to_s)
      return Dir.glob(*args)
    ensure
      Dir.chdir(original_dir)
    end
  end
  
  
  
end