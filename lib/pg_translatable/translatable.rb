require 'pg_translatable/translatable/methods'

module PgTranslatable
  module Translatable
    def translate(*attrs)
      attrs.each do |column|
        Methods::ClassMethods.new(self, column).define_methods
        Methods::InstanceMethods.new(self, column).define_methods
      end
    end
  end
end
