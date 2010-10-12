class Dir
  
  
  
  def Dir.glob_in(path, *args)
    original_dir = Dir.pwd
    begin
      Dir.chdir(path)
      return Dir.glob(*args)
    ensure
      Dir.chdir(original_dir)
    end
  end
  
  
  
end