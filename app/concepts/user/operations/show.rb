# frozen_string_literal: true

class User
  module Operations
    class Show < Trailblazer::Operation
      pass :find_user
      pass :render_json

      def find_user(ctx, user_id:, **)
        ctx[:user] = User.unscoped.includes(captured_pokemons: { pokemon: %i[region types moves] }).find(user_id)
      end

      def render_json(ctx, user:, **)
        ctx[:json] = User::Representers::User.jsonapi_new(user).to_json
      end
    end
  end
end
