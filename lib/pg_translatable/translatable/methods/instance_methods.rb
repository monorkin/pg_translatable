module PgTranslatable
  module Translatable
    class Methods
      class InstanceMethods < PgTranslatable::Translatable::Methods
        def define_methods
          define_formatter
          define_getter
          define_hash_getter_and_setter
          define_locale_setters_and_getters

          define_languages_for_validation
          define_presence_validator
        end

        private

        def define_formatter
          def_method("#{@column_name}_formatter") do |value|
            value
          end
        end

        def define_getter
          def_method(@column_name) do
            send("#{@column_name}_#{I18n.locale}")
          end
        end

        def define_hash_getter_and_setter
          define_hash_getter
          define_hash_setter
        end

        def define_hash_getter
          def_method(@column_name_plural) do
            self[@column] || {}
          end
        end

        def define_hash_setter
          def_method("#{@column_name_plural}=") do |value|
            self[@column] = value
          end
        end

        def define_locale_setters_and_getters
          define_locale_getter
          define_locale_setter
        end

        def define_locale_getter
          @languages.each do |locale|
            def_method("#{@column_name}_#{locale}") do
              send(
                "#{@column_name}_formatter",
                send(@column_name_plural)[locale.to_s]
              )
            end
          end
        end

        def define_locale_setter
          @languages.each do |locale|
            def_method("#{@column_name}_#{locale}=") do |value|
              send(@column_name_plural)[locale.to_s] = send(
                "#{@column_name}_formatter",
                value
              )
            end
          end
        end

        def define_languages_for_validation
          def_method(
            "validate_#{@column_name}_translations_for_locales"
          ) do
            I18n.available_locales
          end
        end

        def define_presence_validator
          method_name = "#{@column_name}_translations_present"
          locales_name = "validate_#{@column_name}_translations_for_locales"

          def_method(method_name) do |locales = nil|
            translations = send(@column_name_plural)
            locales ||= send(locales_name)

            locales.each do |language|
              add_error_for_missing_translation(translations, language)
            end
          end
        end

        ###############
        ### Helpers ###
        ###############

        def def_method(name, &block)
          @object.send(:define_method, name, &block)
        end

        def add_error_for_missing_translation(translations, language)
          errors.add(
            "#{@column_name}_#{language}".to_sym, :translation_missing
          ) unless translations[language.to_s].present?
        end
      end
    end
  end
end
