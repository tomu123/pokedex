# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class Show < Trailblazer::Operation
      pass :set_captured_pokemon
      pass :render_json

      def set_captured_pokemon(ctx, captured_pokemon_id:, **)
        ctx[:captured_pokemon] = CapturedPokemon.unscoped.find(captured_pokemon_id)
      end

      def render_json(ctx, captured_pokemon:, **)
        ctx[:json] = CapturedPokemon::Representers::CapturedPokemon.jsonapi_new(captured_pokemon).to_json
      end
    end
  end
end
