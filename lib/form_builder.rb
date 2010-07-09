class ActionView::Helpers::FormBuilder
  

  def check_box_list(method, collection, value_method=:id, text_method=:to_s, &block)
    object_collection = @object.send(method)
    is_selected_method = lambda{|item| object_collection.include?(item)}
    @template.check_box_list(@object_name, method, collection, value_method, text_method, is_selected_method, &block)
  end
  
  def method_missing(symbol, *args, &block)
    if (match = symbol.to_s.match /^(.*)_with_label$/)
      return <<-HTML
      <label for="#{args.first}">
        <span>#{h args.shift}</span>
        #{send match[1].to_sym, *args, &block}
      </label>
      HTML
    end
    super
  end
  
  
end


module ActionView::Helpers::FormHelper


  def check_box_list(object_name, method, collection, value_method=:id, text_method=:to_s, is_selected_method=nil, &block)
    method_singular = method.to_s.singularize
    html = ""
    for item in collection
      name = "#{object_name}[#{method_singular}_ids][]"
      value = evaluate_method(item, value_method)
      id = "#{method_singular}_#{value}"
      check_box = check_box_tag(name, value, evaluate_method(item, is_selected_method), :id => id) <<
                  label_tag(id, evaluate_method(item, text_method))
      if block_given?
        if block.arity == 2
          html << yield(check_box, item)
        else
          html << yield(check_box)
        end
      else
        html << check_box
      end
    end
    html
  end


private

  
  def evaluate_method(object, method)
    case method
    when Symbol, String
      object.send(method)
    when Proc     
      method.call(object)
    end
  end

  
end




# class ActionView::Helpers::FormBuilder
# 
#   def auto_complete_text_field_tag(method, options={})
#     url = options.delete(:url)
#     #url[:action] = "autocomplete_#{method}"
#  
#     content = @template.text_field_tag(method, options[:value], options)
#     content << "<div class=\"auto_complete\" id=\"#{method}_auto_complete\"></div>"
#     content << @template.auto_complete_field(method, {:url => url})
#   end
#   
# end
# 
# module ActionView::Helpers::FormHelper
# 
#   def auto_complete_text_field_tag(method, options={})
#     url = options.delete(:url)
#     #url[:action] = "autocomplete_#{method}"
#  
#     content = @template.text_field_tag(method, options[:value], options)
#     content << "<div class=\"auto_complete\" id=\"#{method}_auto_complete\"></div>"
#     content << @template.auto_complete_field(method, {:url => url})
#   end
# 
# end