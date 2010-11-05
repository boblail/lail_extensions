module Lail
  module ActionPackExtensions
    module ActionBuilder
      module ClassMethods
        
        
        
        #
        # options
        #   :belongs_to => when :belongs_to is defined, `has_actions_for` will fetch and create
        #                  only models that belong to the parent resource
        #   :as =>         used with :belongs_to when the parent's collection of this resource is
        #                  not the typical tablized plural of the model's name
        #
        def has_actions_for(model, *args)
          options = args.extract_options!
          
          actions = get_actions(options)
          collection_name = model.name.tableize
          instance_name = collection_name.singularize
          define_method(:model)           {model}
          
    #
    #     This method took advantage of scopes --- which seems to be the superior
    #     way of using `has_actions_for` with nested resources.
    #
    #     Unfortunately, a named scope like `for_account` must be passed the account
    #     and when passing the account inside a lambda, the lambda is evaluated in
    #     the scope of the model rather than of the controller
    #
=begin
          define_method(:model)           {model}
          if scope = options[:scope]
            define_method(:scoped_model)  {@scoped_model ||= (scope.is_a?(Array) ? model.send(*scope) : model.send(scope))}
          else
            define_method(:scoped_model)  {model}
          end
          define_method(:make_model)    {|*args| self.scoped_model.new(*args)}
          define_method(:find_model)    {|id|    self.scoped_model.find_by_id(id)}
          define_method(:find_models)   {|*args| self.scoped_model.all(*args)}
=end

    #
    #     This method tries to parse a string like "@account.tags" which could be passed
    #     to `has_actions_for` in lieu of a model; but it became too complex
    #
=begin      
          options[:in], model = model.split(".") if model.is_a?(String)
          model = model.to_sym if model.is_a?(String)
      
          case model
          when Class
            define_method(:model)         {model}
            define_method(:make_model)    {|*args| self.model.new(*args)}
            define_method(:find_model)    {|id|    self.model.find_by_id(id)}
            define_method(:find_models)   {|*args| self.model.all(*args)}
          when Symbol
            raise ":in => [object] is required" unless options[:in]
            define_method(:__parse_model) do
              unless @__model_owner
                @__model_owner = eval(options[:in].to_s)
                @__association = @__model_owner.send model
                @model = 
              end
            end
            define_method(:model)         { self.__parse_model; @model}
            define_method(:make_model)    {|*args| self.__parse_model; self.model.build(*args)}
            define_method(:find_model)    {|*args| self.__parse_model; }
          end
=end


          belongs_to = options[:belongs_to]
          if belongs_to
            has_many_collection = collection_name || options[:as]
            define_method(:__haf_scope)   {@__haf_collection ||= instance_variable_get(belongs_to).send(has_many_collection)}
            define_method(:make_model)    {|*args| __haf_scope.build(*args)}
          else  
            define_method(:__haf_scope)   {model}
            define_method(:make_model)    {|*args| model.new(*args)}
          end  
          define_method(:find_model)      {|*args| __haf_scope.find(*args)}
          define_method(:find_models)     {|*args| __haf_scope.all(*args)}
          
          
          define_method "index" do
            collection = find_models(eval_params(options[:find]))
            instance_variable_set("@#{collection_name}", collection)
            instance_variable_set("@#{instance_name}", make_model(eval_params(options[:new]))) # if (resource_type == :simple_record)
            respond_with(collection)
          end if actions.member? :index
          
          define_method "show" do
            record = find_model(params[:id])
            instance_variable_set("@#{instance_name}", record)
            respond_with(record)
          end if actions.member? :show
          
          define_method "new" do
            record = make_model(eval_params(options[:new]))
            instance_variable_set("@#{instance_name}", record)
            respond_with(record)
          end if actions.member? :new
          
          define_method "edit" do
            record = find_model(params[:id])
            instance_variable_set("@#{instance_name}", record)
          end if actions.member? :edit
          
          define_method "create" do
            record = make_model(params[instance_name])
            instance_variable_set("@#{instance_name}",record)
            record.save
            respond_with(record)
          end if actions.member? :create
          
          define_method "update" do
            record = find_model(params[:id])
            instance_variable_set("@#{instance_name}",record)
            record.update_attributes(params[instance_name])
            respond_with(record)
          end if actions.member? :update
          
          define_method "destroy" do
            record = find_model(params[:id])
            instance_variable_set("@#{instance_name}",record)
            record.destroy
            respond_with(record)
          end if actions.member? :destroy
        end
        
        
        
      private
        
        
        
        def get_actions(options={})
          only = options[:only]
          except = options[:except]
          return only if only
          return (standard_actions - except) if except
          return standard_actions
        end
        
        
        
        def standard_actions
          [:index, :show, :new, :create, :edit, :update, :destroy]
        end
        
        
        
      end
      
      
      
    private
      
      
      
      def self.included(other_module)
        other_module.extend ClassMethods
      end
      
      
      
      def eval_params(params)
        case params
        when Symbol
          send params
        else
          params || {}
        end
        # finder_hash.is_a?(Symbol) ? send(finder_hash) : finder_hash
      end
    end
  end
end

