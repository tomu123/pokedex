# frozen_string_literal: true

class Pokemon
  module Operations
    class Capture < Trailblazer::Operation
      pass :set_pokemon
      pass :create_captured_pokemon_form
      pass :validate_form
      pass :capture_pokemon
      pass :find_pokemon
      pass :render_json

      def set_pokemon(ctx, pokemon_id:, **)
        ctx[:pokemon] = Pokemon.find(pokemon_id)
      end

      def create_captured_pokemon_form(ctx, pokemon:, current_user:, **)
        ctx[:captured_pokemon] = CapturedPokemon.new(pokemon: pokemon, user: current_user)
        ctx[:captured_pokemon_form] = CapturedPokemon::Forms::CapturedPokemonForm.new(ctx[:captured_pokemon])
      end

      def validate_form(_ctx, captured_pokemon_form:, pokemon:, **)
        return if captured_pokemon_form.validate(pokemon.attributes.with_indifferent_access)

        raise CustomError.new(error: :argument_error, status: :unprocessable_entity,
                              message: captured_pokemon_form.errors.to_hash)
      end

      def capture_pokemon(_ctx, captured_pokemon_form:, **)
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
