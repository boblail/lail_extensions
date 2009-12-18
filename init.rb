require 'action_builder';
require 'duration';
require 'enumerable';
require 'errors';
require 'flash_message';
require 'formatting_helper';
Hash.send :include, HashExtensions
ActionView::Base.send :include, FlashMessage
ActionController::Base.send :include, ActionBuilder