begin
  require 'metric_fu'
  
  MetricFu::Configuration.run do |config|
    config.metrics  = [:churn, :flog, :rcov, :reek, :roodi, :stats, :rails_best_practices]
#   config.graphs   = [:flog, :flay, :stats]
    @base_directory = Rails.root.to_s.gsub(/\/([^\/]*)$/, '/metric_fu/\1')
    config.base_directory = @base_directory
    config.scratch_directory = File.join(@base_directory, 'scratch')
    config.output_directory = File.join(@base_directory, 'output')
    config.data_directory = File.join(@base_directory, '_data')
    config.rcov = {   :environment => 'test',
                      :test_files => ["test/unit/*_test.rb",
                                      "test/functional/*_test.rb", 
                                      "test/integration/*_test.rb"],
                      :rcov_opts => ["--sort coverage", 
                                     "--no-html",
                                     "--text-coverage",
                                     "--no-color",
                                     "--profile",
                                     "--rails",
                                     "--exclude /\.rvm/,/gems/,/\.bundle/",
                                     "-Itest"],
                      :external => nil
                   }
  end
  
rescue LoadError
  # If metric_fu isn't included in Gemfile, don't worry about this task
end
