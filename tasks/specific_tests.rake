# http://mentalized.net/journal/2006/07/28/run_specific_tests_via_rake/
#  by Geoffrey Grosenbach
#  modified by Jakob Skjerning and Bob Lail

# Run specific tests or test files
# 
# rake test:blog
# => Runs the full BlogTest unit test
# 
# rake test:blog:create
# => Runs the tests matching /create/ in the BlogTest unit test
# 
# rake test:blog_controller
# => Runs all tests in the BlogControllerTest functional test
# 
# rake test:blog_controller:create
# => Runs the tests matching /create/ in the BlogControllerTest functional test	
rule "" do |t|
  # test:file:method
  if /test:(.*)(:([^.]+))?$/.match(t.name)
    arguments = t.name.split(":")[1..-1] # skip test:
    file_pattern = arguments.shift
    test_pattern = arguments.shift
    file_name = "#{file_pattern}_test"
    
    tests = Dir.glob('test/**/*_test.rb').select{|file| file.match(file_name)}

=begin    
    if File.exist?("test/unit/#{file_name}_test.rb")
      run_file_name = "unit/#{file_name}_test.rb" 
    elsif File.exist?("test/functional/#{file_name}_controller_test.rb")
      run_file_name = "functional/#{file_name}_controller_test.rb" 
    elsif File.exist?("test/functional/#{file_name}_test.rb")
      run_file_name = "functional/#{file_name}_test.rb"
    else
=end

    if tests.empty?
      puts "no test was found with the file name \"#{file_name}\""
    else
      sh "ruby -Ilib:test #{tests.join(' ')} #{"-n /#{test_pattern}/" if test_pattern}"
    end
  end
end