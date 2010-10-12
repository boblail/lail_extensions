module Lail
  module ActionPackExtensions
    module DebugParams
      include ::Lail::Helpers::FormattingHelper
      
      
      
      def debug_params
        render(:update) {|page| page.alert(format_params)}
      end
      
      
      
    end
  end
end