# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class Update < Trailblazer::Operation
      pass :set_captured_pokemon
      pass :create_captured_pokemon_form
      pass :validate_form
      pass :update_captured_pokemon
      pass :find_captured_pokemon
      pass :render_json

      def set_captured_pokemon(ctx, captured_pokemon_id:, **)
        ctx[:captured_pokemon] = CapturedPokemon.find(captured_pokemon_id)
      end

      def create_captured_pokemon_form(ctx, captured_pokemon:, **)
        ctx[:captured_pokemon_form] = CapturedPokemon::Forms::CapturedPokemonForm.new(captured_pokemon)
      end

      def validate_form(_ctx, captured_pokemon_form:, captured_pokemon_data:, **)
        return if captured_pokemon_form.validate(captured_pokemon_data)

        raise CustomError.new(error: :argument_error, status: :unprocessable_entity,
                              message: captured_pokemon_form.errors.to_hash)
      end

      def update_captured_pokemon(_ctx, captured_pokemon_form:, **)
        captured_pokemon_form.save
      end

      def find_captured_pokemon(ctx, captured_pokemon:, **)
        ctx[:captured_pokemon] = CapturedPokemon.includes(pokemon: %i[region types moves]).find(captured_pokemon.id)
      end

      def render_json(ctx, captured_pokemon:, **)
        ctx[:json] = CapturedPokemon::Representers::CapturedPokemon.jsonapi_new(captured_pokemon).to_json
      end
    end
  end
end
