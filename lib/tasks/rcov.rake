begin
  require 'rcov/rcovtask'
  
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
rescue LoadError
  # If rcov isn't included in Gemfile, don't worry about this task
end