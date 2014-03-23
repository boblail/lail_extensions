require 'lail/action_pack_extensions/action_builder'
ActionController::Base.send :include, Lail::ActionPackExtensions::ActionBuilder

if !defined?(ActionView::Helpers::PrototypeHelper::JavaScriptGenerator)
  begin
    require 'action_view/helpers/prototype_helper'
  rescue LoadError
  end
end

if defined?(ActionView::Helpers::PrototypeHelper::JavaScriptGenerator)
  require 'lail/action_pack_extensions/flash_message_updater'
  ActionView::Helpers::PrototypeHelper::JavaScriptGenerator.send :include, Lail::ActionPackExtensions::FlashMessageUpdater
end
