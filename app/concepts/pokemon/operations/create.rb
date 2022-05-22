# frozen_string_literal: true

class Pokemon
  module Operations
    class Create < Trailblazer::Operation
      pass :create_pokemon_form
      pass :validate_form
      pass :create_pokemon
      pass :attach_image
      pass :find_pokemon
      pass :render_json

      def create_pokemon_form(ctx, **)
        ctx[:pokemon] = Pokemon.new
        ctx[:pokemon_form] = Pokemon::Forms::Pokemon.new(ctx[:pokemon])
      end

      def validate_form(_ctx, pokemon_form:, pokemon_data:, **)
        return if pokemon_form.validate(pokemon_data)

        raise CustomError.new(error: :argument_error, status: :unprocessable_entity,
                              message: pokemon_form.errors.to_hash)
      end

      def create_pokemon(_ctx, pokemon_form:, **)
        pokemon_form.save
      end

      def attach_image(_ctx, pokemon:, pokemon_image:, **)
        return if pokemon_image.blank?

        pokemon.image.attach(io: pokemon_image.tempfile, filename: "pokemon_#{pokemon.id}.jpg")
      end

      def find_pokemon(ctx, pokemon:, **)
        ctx[:pokemon] = Pokemon.includes(:region, :types, :moves).find(pokemon.id)
      end

      def render_json(ctx, pokemon:, **)
        ctx[:json] = Pokemon::Representers::Pokemon.jsonapi_new(pokemon).to_json
      end
    end
  end
end
