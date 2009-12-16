require 'action_builder.rb';
require 'duration.rb';
require 'enumerable.rb';
require 'errors.rb';
require 'flash_message';
require 'formatting_helper';
ActionView::Base.send :include, FlashMessage
ActionController::Base.send :include, ActionBuilder