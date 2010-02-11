require 'action_builder';
require 'assets_helper';
require 'date_extensions';
require 'duration';
require 'enumerable';
require 'errors';
require 'flash_message';
require 'formatting_helper';
require 'to_slug.rb';

ActionView::Base.send :include, FlashMessage
ActionView::Base.send :include, AssetsHelper
ActionController::Base.send :include, ActionBuilder
String.send(:include, ToSlug)