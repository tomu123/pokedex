# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class Destroy < Trailblazer::Operation
      pass :set_captured_pokemon
      pass :destroy_captured_pokemon

      def set_captured_pokemon(ctx, captured_pokemon_id:, **)
        ctx[:captured_pokemon] = CapturedPokemon.find(captured_pokemon_id)
      end

      def destroy_captured_pokemon(_ctx, captured_pokemon:, **)
        captured_pokemon.soft_destroy
      end
    end
  end
end
