class ActionView::Helpers::FormBuilder
  

  def check_box_list(method, collection, value_method=:id, text_method=:to_s, &block)
    object_collection = @object.send(method)
    is_selected_method = lambda{|item| object_collection.include?(item)}
    @template.check_box_list(@object_name, method, collection, value_method, text_method, is_selected_method, &block)
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
        html << yield(check_box)
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