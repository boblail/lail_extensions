module Lail
  module TestExtensions
    module ValidationAssertions
      
      
      
      def assert_valid(record)
        assert record.valid?, record.errors.all_messages.join("\n")
      end
      
      
      
      def assert_valid_and_save!(record)
        assert_valid(record)
        record.save!
        record
      end
      
      
      
    end
  end
end
