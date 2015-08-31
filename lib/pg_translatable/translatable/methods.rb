require 'pg_translatable/translatable/methods/class_methods'
require 'pg_translatable/translatable/methods/instance_methods'

module PgTranslatable
  module Translatable
    class Methods
      def initialize(object, column)
        @object = object
        @column = column
        @languages = I18n.available_locales

        raise_wrong_column_object_type

        @column_name = @column.to_s.singularize
        @column_name_plural = @column.to_s.pluralize

        ensure_different_plural
        load_column_type
      end

      private

      def load_column_type
        @type = @object.columns_hash[@column.to_s].type
        raise_wrong_column_type
      rescue ActiveRecord::StatementInvalid
        @type = :unknown
      end

      def ensure_different_plural
        return unless @column_name_plural == @column_name
        @column_name_plural = "#{@column_name_plural}_translations"
      end

      def raise_wrong_column_type
        accepted_types = [:hstore, :json, :jsonb]

        return if accepted_types.include?(@type)

        fail(
          ArgumentError,
          "Expected column '#{@column}' to be of type "\
          "#{accepted_types.map { |type| type.to_s.upcase }.join(', ')} "\
          "but was of type #{@type}"
        )
      end

      def raise_wrong_column_object_type
        return if @column.is_a?(String)
        return if @column.is_a?(Symbol)

        fail(
          ArgumentError,
          'Pass the column name as a String or Symbol. '\
          "You passed a #{@column.class.name}!"
        )
      end
    end
  end
end
