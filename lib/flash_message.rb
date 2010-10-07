require 'flash_message/helper'
require 'flash_message/updater'

ActionView::Base.send :include, FlashMessage::Helper
ActionView::Helpers::JavaScriptGenerator.send :include, FlashMessage::Updater
