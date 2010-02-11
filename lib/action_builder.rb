# require 'rails3_backport/mime_responds';

module ActionBuilder


  module ClassMethods


    def has_actions_for(model, *args)
      @model = model
      class << self
        define_method :model do 
          @model
        end
      end
      define_method :model do 
        self.class.model
      end

      options = args.extract_options!
      actions = get_actions(options)
      collection_name = model.name.tableize
      instance_name = collection_name.singularize

      define_method "index" do
        collection = model.find(:all, eval_params(options[:find]))
        instance_variable_set("@#{collection_name}", collection)
        instance_variable_set("@#{instance_name}", model.new(eval_params(options[:new]))) # if (resource_type == :simple_record)
        respond_with(collection)
      end if actions.member? :index
      
      define_method "show" do
        record = model.find(params[:id])
        instance_variable_set("@#{instance_name}", record)
        respond_with(record)
      end if actions.member? :show
    
      define_method "new" do
        record = model.new(eval_params(options[:new]))
        instance_variable_set("@#{instance_name}", record)
        respond_with(record)
      end if actions.member? :new

      define_method "edit" do
        record = model.find(params[:id])
        instance_variable_set("@#{instance_name}", record)
      end if actions.member? :edit
    
      define_method "create" do
        record = model.new(params[instance_name])
        instance_variable_set("@#{instance_name}",record)
        record.save
        respond_with(record)
      end if actions.member? :create

      define_method "update" do
        record = model.find(params[:id])
        instance_variable_set("@#{instance_name}",record)
        record.update_attributes(params[instance_name])
        respond_with(record)
      end if actions.member? :update

      define_method "destroy" do
        record = model.find(params[:id])
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