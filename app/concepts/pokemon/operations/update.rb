# frozen_string_literal: true

class Pokemon
  module Operations
    class Update < Trailblazer::Operation
      pass :set_pokemon
      pass :create_pokemon_form
      pass :validate_form
      pass :update_pokemon
      pass :attach_image
      pass :find_pokemon
      pass :render_json

      def set_pokemon(ctx, pokemon_id:, **)
        ctx[:pokemon] = Pokemon.find(pokemon_id)
      end

      def create_pokemon_form(ctx, pokemon:, **)
        ctx[:pokemon_form] = Pokemon::Forms::Pokemon.new(pokemon)
      end

      def validate_form(_ctx, pokemon_form:, pokemon_data:, **)
        return if pokemon_form.validate(pokemon_data)

        raise CustomError.new(error: :argument_error, status: :unprocessable_entity,
                              message: pokemon_form.errors.to_hash)
      end

      def update_pokemon(_ctx, pokemon_form:, **)
        pokemon_form.save
      end

      def attach_image(_ctx, pokemon:, pokemon_image:, **)
        return if pokemon_image.blank?

        if pokemon.image.attached?
          pokemon.image.variant(resize_to_limit: [220, 220]).image.purge if pokemon.image.variant(resize_to_limit: [
                                                                                                    220, 220
                                                                                                  ]).image&.attached?
          pokemon.image.purge
        end
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
