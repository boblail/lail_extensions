# if (RAILS_ENV=="development")
#   require 'metric_fu'
#   MetricFu::Configuration.run do |config|
# #   config.metrics  = [:churn, :saikuro, :stats, :flog, :flay]
# #   config.graphs   = [:flog, :flay, :stats]
#     @base_directory = Rails.root.to_s.gsub(/\/([^\/]*)$/, '/metric_fu/\1')
#     config.base_directory = @base_directory
#     config.scratch_directory = File.join(@base_directory, 'scratch')
#     config.output_directory = File.join(@base_directory, 'output')
#     config.data_directory = File.join(@base_directory, '_data')
#     config.rcov = {   :environment => 'test',
#                       :test_files => ["test/**/*_test.rb"],
#                       :rcov_opts => ["--sort coverage", 
#                                      "--no-html",
#                                      "--text-coverage",
#                                      "--no-color",
#                                      "--profile",
#                                      "--rails",
#                                      "--exclude /\.rvm/,/gems/,/\.bundle/",
#                                      "-Itest"],
#                       :external => nil
#                    }
#   end
# end
