# frozen_string_literal: true

module Application
  module Representer
    class ApplicationRepresenter < Representable::Decorator
      include Representable::JSON

      def self.jsonapi_new(...)
        { data: new(...) }
      end

      def self.jsonapi_for_collection(...)
        { data: for_collection.new(...) }
      end
    end
  end
end
