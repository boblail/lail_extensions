require 'active_support'
require 'active_support/test_case'

require 'lail/test_extensions/test_helpers'
ActiveSupport::TestCase.extend Lail::TestExtensions::TestHelpers

require 'lail/test_extensions/validation_assertions'
ActiveSupport::TestCase.send(:include, Lail::TestExtensions::ValidationAssertions)
