# frozen_string_literal: true

class Pokemon
  module Operations
    class Destroy < Trailblazer::Operation
      pass :set_pokemon
      pass :destroy_pokemon

      def set_pokemon(ctx, pokemon_id:, **)
        ctx[:pokemon] = Pokemon.find(pokemon_id)
      end

      def destroy_pokemon(_ctx, pokemon:, **)
        pokemon.destroy
      end
    end
  end
end
