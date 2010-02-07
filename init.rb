require 'duration.rb';
require 'enumerable.rb';
require 'errors.rb';
require 'flash_message';
require 'formatting_helper';
ActionView::Base.send :include, FlashMessage

require 'to_slug.rb';
String.send(:include, ToSlug)