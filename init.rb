require 'active_support'

require 'action_builder';
require 'action_controller';
require 'assets_helper';
require 'date_extensions';
require 'duration';
require 'enumerable';
require 'errors_extensions';
require 'flash_message';
require 'formatting_helper';
require 'hash_extensions';
require 'to_slug';
require 'test_helpers';

ActionView::Base.send :include, FlashMessage
ActionView::Base.send :include, AssetsHelper
ActionController::Base.send :include, ActionBuilder
String.send(:include, ToSlug)

require 'active_support/test_case'
ActiveSupport::TestCase.extend TestHelpers