# frozen_string_literal: true

class User
  module Operations
    class Recover < Trailblazer::Operation
      pass :set_user
      pass :recover_user
      pass :find_user
      pass :render_json

      def set_user(ctx, user_id:, **)
        ctx[:user] = User.filter('deleted').find(user_id)
      end

      def recover_user(_ctx, user:, **)
        user.recover
      end

      def find_user(ctx, user:, **)
        ctx[:user] = User.includes(captured_pokemons: { pokemon: %i[region types moves] }).find(user.id)
      end

      def render_json(ctx, user:, **)
        ctx[:json] = User::Representers::User.jsonapi_new(user).to_json
      end
    end
  end
end
