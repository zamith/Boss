module Boss
  module Pagination

    def get_class_name(name)
      name.match(/.*?\:?([^:]*$|$)/)[1].underscore.pluralize
    end
    module_function :get_class_name

    def self.included(base)
      class_name = Pagination.get_class_name(base.name)
      base.send :define_singleton_method, "#{class_name}_for_index", lambda { |options={}|
        options.keys.map(&:to_sym)
        options = { index_limit: Object.const_get(class_name.upcase.to_sym)["index_limit"], conditions: {} }.merge options

        if options[:starts_at] && options[:starts_at] != 0
          base.limit(options[:index_limit]).offset(options[:starts_at]).where(options[:conditions])
        elsif options[:starts_at] && options[:starts_at] == 0
          []
        else
          base.limit(options[:index_limit]).where(options[:conditions])
        end
      }
    end

  end
end
