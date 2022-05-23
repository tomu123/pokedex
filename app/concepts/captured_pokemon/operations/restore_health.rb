# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class RestoreHealth < Update
      def create_captured_pokemon_form(ctx, captured_pokemon:, **)
        ctx[:captured_pokemon_form] = CapturedPokemon::Forms::RestoreHealthForm.new(captured_pokemon)
      end
    end
  end
end
