require 'lail/action_pack_extensions/action_builder'
ActionController::Base.send :include, Lail::ActionPackExtensions::ActionBuilder

require 'lail/action_pack_extensions/debug_params'
ActionController::Base.send :include, Lail::ActionPackExtensions::DebugParams

require 'lail/action_pack_extensions/flash_message_updater'
ActionView::Helpers::JavaScriptGenerator.send :include, Lail::ActionPackExtensions::FlashMessageUpdater
