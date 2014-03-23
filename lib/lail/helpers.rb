require 'lail/helpers/flash_message_helper'
require 'lail/helpers/formatting_helper'

ActionView::Base.send       :include, Lail::Helpers::FlashMessageHelper
ActionView::Base.send       :include, Lail::Helpers::FormattingHelper
ActionController::Base.send :include, Lail::Helpers::FormattingHelper
