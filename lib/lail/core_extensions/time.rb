require 'active_support/all'
require 'lail/core_extensions/duration'

module Lail
  module CoreExtensions
    module Time
      
      def round(seconds = 60)
        ::Time.at((self.to_f / seconds).round * seconds)
      end
      
      def floor(seconds = 60)
        ::Time.at((self.to_f / seconds).floor * seconds)
      end
      
      def ceil(seconds = 60)
        ::Time.at((self.to_f / seconds).ceil * seconds)
      end
      
    end
  end
end

Time.send     :include, Lail::CoreExtensions::Time
DateTime.send :include, Lail::CoreExtensions::Time
