require 'rcov/rcovtask'

=begin
namespace :test do
  namespace :coverage do
    desc "Delete aggregate coverage data."
    task(:clean) { rm_f "coverage.data" }
  end

  # desc 'Aggregate code coverage for unit, functional and integration tests'
  # task :coverage => "test:coverage:clean"
  # %w[unit functional integration].each do |target|
  #   namespace :coverage do
  #     Rcov::RcovTask.new(target) do |t|
  #       t.libs << "test"
  #       t.test_files = FileList["test/#{target}/*_test.rb"]
  #       t.output_dir = "rcov/#{target}"
  #       t.verbose = false
  #       t.rcov_opts << '--rails --aggregate coverage.data --exclude /home\/deploy\/\.rvm\/rubies\/ruby\-1\.8\.7\-p249/'
  #     end
  #   end
  #   task :coverage => "test:coverage:#{target}"
  # end

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
=end

namespace :test do

  desc 'Aggregate code coverage for unit, functional and integration tests'
  Rcov::RcovTask.new(:coverage) do |t|
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"]
    t.output_dir = Rails.root.to_s.gsub(/\/([^\/]*)$/, '/rcov/\1')
    t.verbose = true
#   t.rcov_opts << '--rails --aggregate coverage.data --text-summary'
    t.rcov_opts << '--rails --exclude /\.bundle/,/\.rvm/'
  end


end