require 'rcov/rcovtask'

namespace :test do
  namespace :coverage do
    desc "Delete aggregate coverage data."
    task(:clean) { rm_f "coverage.data" }
  end
=begin
  desc 'Aggregate code coverage for unit, functional and integration tests'
  task :coverage => "test:coverage:clean"
  %w[unit functional integration].each do |target|
    namespace :coverage do
      Rcov::RcovTask.new(target) do |t|
        t.libs << "test"
        t.test_files = FileList["test/#{target}/*_test.rb"]
        t.output_dir = "rcov/#{target}"
        t.verbose = false
        t.rcov_opts << '--rails --aggregate coverage.data --exclude /home\/deploy\/\.rvm\/rubies\/ruby\-1\.8\.7\-p249/'
      end
    end
    task :coverage => "test:coverage:#{target}"
  end
=end
  Rcov::RcovTask.new(:__rcov_all) do |t|
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"]
    t.output_dir = "rcov/all"
    t.verbose = false
    t.rcov_opts << '--rails --aggregate coverage.data --exclude /\.rvm/'
  end
  
  desc 'Aggregate code coverage for unit, functional and integration tests'
  task :coverage => "test:coverage:clean"
  task :coverage => "test:__rcov_all"
end