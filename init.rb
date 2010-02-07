require 'action_builder';
require 'date_extensions';
require 'duration';
require 'enumerable';
require 'errors';
require 'flash_message';
require 'formatting_helper';
require 'to_slug.rb';

ActionView::Base.send :include, FlashMessage
String.send(:include, ToSlug)