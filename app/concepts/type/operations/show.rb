# frozen_string_literal: true

class Type
  module Operations
    class Show < Trailblazer::Operation
      pass :set_type
      pass :render_json

      def set_type(ctx, type_id:, **)
        ctx[:type] = Type.find(type_id)
      end

      def render_json(ctx, type:, **)
        ctx[:json] = Type::Representers::Type.jsonapi_new(type).to_json
      end
    end
  end
end
