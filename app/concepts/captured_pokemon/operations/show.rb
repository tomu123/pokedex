# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class Show < Trailblazer::Operation
      pass :set_captured_pokemon
      pass :render_json

      def set_captured_pokemon(ctx, current_user:, captured_pokemon_id:, **)
        if current_user.doctor_role?
          ctx[:captured_pokemon] = CapturedPokemon.unscoped.find(captured_pokemon_id)
        elsif current_user.trainer_role?
          ctx[:captured_pokemon] = CapturedPokemon.unscoped.where(user: current_user).find(captured_pokemon_id)
        end
      end

      def render_json(ctx, captured_pokemon:, **)
        ctx[:json] = CapturedPokemon::Representers::CapturedPokemon.jsonapi_new(captured_pokemon).to_json
      end
    end
  end
end
