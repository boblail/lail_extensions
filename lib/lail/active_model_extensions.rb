require 'lail/active_model_extensions/errors'

ActiveRecord::Errors.send(:include, Lail::ActiveModelExtensions::Errors) if defined?(ActiveRecord::Errors)
ActiveModel::Errors.send(:include, Lail::ActiveModelExtensions::Errors) if defined?(ActiveModel::Errors)
