module Lail
  module TestExtensions
    module TestHelpers
      
      
      
      def self.extended(base)
        @@helpers_path = "#{Rails.root}/test/helpers"
        @@base = base
        @@included_helpers = []
      end
      
      
      
      def helper(*args)
        for arg in args
          case arg
          when :all
            helper *all_helpers
          else
            arg = arg.to_s
            arg = (md = arg.match(/(.*).rb/)) ? md[1] : arg
            unless @@included_helpers.member?(arg)
              require "#{@@helpers_path}/#{arg}"
              @@base.send(:include, arg.camelize.constantize)
              @@included_helpers << arg
            end
          end
        end
      end
      
      
      
      def all_helpers
        Dir.entries(@@helpers_path).select{|s| s=~/\.rb/}
      end
      
      
      
    end
  end
end
