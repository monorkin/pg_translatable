module PgTranslatable
  module Translatable
    class Methods
      class ClassMethods < PgTranslatable::Translatable::Methods
        def define_methods
          define_strong_params_fields
        end

        private

        def define_strong_params_fields
          languages_list = @languages.map do |locale|
            ":#{@column_name}_#{locale}"
          end

          @object.class_eval <<-RUBY
            define_singleton_method("#{@column_name}_fields") do
              [#{languages_list.join(', ')}]
            end
          RUBY
        end
      end
    end
  end
end
