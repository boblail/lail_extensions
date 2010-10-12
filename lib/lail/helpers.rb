require 'lail/helpers/assets_helper'
require 'lail/helpers/flash_message_helper'
require 'lail/helpers/formatting_helper'

ActionView::Base.send       :include, Lail::Helpers::AssetsHelper
ActionView::Base.send       :include, Lail::Helpers::FlashMessageHelper
ActionView::Base.send       :include, Lail::Helpers::FormattingHelper
ActionController::Base.send :include, Lail::Helpers::FormattingHelper

# require 'lail/helpers/form_builder'
require 'lail/helpers/tab_builder'
