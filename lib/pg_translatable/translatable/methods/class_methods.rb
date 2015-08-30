module PgTranslatable
  module Translatable
    class Methods
      class ClassMethods < PgTranslatable::Translatable::Methods
        def define_methods
          define_strong_params_fields
        end

        private

        def define_strong_params_fields
          @object.define_singleton_method("#{@column}_fields") do
            @languages.map { |locale| "#{@column}_#{locale}" }
          end
        end
      end
    end
  end
end
