class ActionController::Base
  include FormattingHelper
  
  # !tood: move to render module
  def xhr_debug_params
    render(:update) {|page| page.alert(format_params)}
  end
  
end