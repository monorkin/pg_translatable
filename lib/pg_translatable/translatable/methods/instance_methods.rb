module PgTranslatable
  module Translatable
    class Methods
      class InstanceMethods < PgTranslatable::Translatable::Methods
        def define_methods
          define_formatter
          define_getter
          define_hash_getter_and_setter
          define_locale_setters_and_getters
        end

        private

        def define_formatter
          @object.class_eval <<-RUBY
            define_method("#{@column_name}_formatter") do |value|
              value
            end
          RUBY
        end

        def define_getter
          @object.class_eval <<-RUBY
            define_method("#{@column_name}") do
              send("#{@column_name}_\#{I18n.locale}")
            end
          RUBY
        end

        def define_hash_getter_and_setter
          define_hash_getter
          define_hash_setter
        end

        def define_hash_getter
          @object.class_eval <<-RUBY
            define_method("#{@column_name_plural}") do
              self["#{@column}"] || {}
            end
          RUBY
        end

        def define_hash_setter
          @object.class_eval <<-RUBY
            define_method("#{@column_name_plural}=") do |value|
              self[:#{@column}] = value
            end
          RUBY
        end

        def define_locale_setters_and_getters
          define_locale_getter
          define_locale_setter
        end

        def define_locale_getter
          @languages.each do |locale|
            @object.class_eval <<-RUBY
              define_method("#{@column_name}_#{locale}") do
                send("#{@column_name}_formatter",
                  send("#{@column_name_plural}")["#{locale}"]
                )
              end
            RUBY
          end
        end

        def define_locale_setter
          @languages.each do |locale|
            @object.class_eval <<-RUBY
              define_method("#{@column_name}_#{locale}=") do |value|
                translations = send("#{@column_name_plural}")
                translations["#{locale}"] = value
                self[:#{@column}] = translations
                value
              end
            RUBY
          end
        end
      end
    end
  end
end
