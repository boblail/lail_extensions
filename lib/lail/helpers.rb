require 'lail/helpers/assets_helper'
require 'lail/helpers/flash_message_helper'
require 'lail/helpers/formatting_helper'
require 'lail/helpers/tab_builder_helper'

ActionView::Base.send       :include, Lail::Helpers::AssetsHelper
ActionView::Base.send       :include, Lail::Helpers::FlashMessageHelper
ActionView::Base.send       :include, Lail::Helpers::FormattingHelper
ActionController::Base.send :include, Lail::Helpers::FormattingHelper
ActionView::Base.send       :include, Lail::Helpers::TabBuilderHelper
