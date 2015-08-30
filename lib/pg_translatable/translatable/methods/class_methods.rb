module PgTranslatable
  module Translatable
    class Methods
      class ClassMethods < PgTranslatable::Translatable::Methods
        def define_methods
          define_strong_params_fields
        end

        private

        def define_strong_params_fields
          languages_list = @languages.map { |locale| ":#{@column}_#{locale}" }
          @object.class_eval <<-RUBY
            define_singleton_method("#{@column}_fields") do
              [#{languages_list.join(', ')}]
            end
          RUBY
        end
      end
    end
  end
end
