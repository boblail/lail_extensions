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
  if /^test:(.*)(:([^.]+))?$/.match(t.name)
    arguments = t.name.split(":")[1..-1] # skip test:
    file_pattern = arguments.shift
    test_pattern = arguments.shift
    file_name = "#{file_pattern}_test.rb"

    # the following works but it doesn't seem I can run multiple files with the -n switch
=begin
    tests = Dir.glob('test/**/*_test.rb').select{|file| file.match(file_name)}
    if tests.empty?
      puts "no test was found with the file name \"#{file_name}\""
    else
      sh "ruby -Ilib:test \"/usr/local/lib/ruby/1.9.1/rake/rake_test_loader.rb\" #{tests.join(' ')} #{"-n /#{test_pattern}/" if test_pattern}"
    end
=end

  # rake_test_loader = '/opt/local/lib/ruby/gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader.rb'
  rake_test_loader = Gem.find_files('rake/rake_test_loader.rb')
    if test = Dir.glob("test/**/#{file_name}").first
      sh "ruby -Ilib:test \"#{rake_test_loader}\" #{test} #{"-n /#{test_pattern}/" if test_pattern}"
    else
      puts "no test was found with the file name \"#{file_name}\""
    end
  end
end