# frozen_string_literal: true

class Pokemon
  module Operations
    class Show < Trailblazer::Operation
      pass :set_pokemon
      pass :render_json

      def set_pokemon(ctx, pokemon_id:, **)
        ctx[:pokemon] = Pokemon.includes(:region, :types, :moves).find(pokemon_id)
      end

      def render_json(ctx, pokemon:, **)
        ctx[:json] = Pokemon::Representers::Pokemon.jsonapi_new(pokemon).to_json
      end
    end
  end
end
