require 'lail/action_pack_extensions/action_builder'
ActionController::Base.send :include, Lail::ActionPackExtensions::ActionBuilder

require 'lail/action_pack_extensions/debug_params'
ActionController::Base.send :include, Lail::ActionPackExtensions::DebugParams

if defined?(ActionView::Helpers::PrototypeHelper::JavaScriptGenerator)
  require 'lail/action_pack_extensions/flash_message_updater'
  ActionView::Helpers::PrototypeHelper::JavaScriptGenerator.send :include, Lail::ActionPackExtensions::FlashMessageUpdater
end
