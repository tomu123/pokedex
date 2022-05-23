# frozen_string_literal: true

class User
  module Operations
    class Update < Trailblazer::Operation
      pass :set_user
      pass :create_user_form
      pass :validate_form
      pass :update_user
      pass :find_user
      pass :render_json

      def set_user(ctx, user_id:, **)
        ctx[:user] = User.find(user_id)
      end

      def create_user_form(ctx, user:, **)
        ctx[:user_form] = User::Forms::UserForm.new(user)
      end

      def validate_form(_ctx, user_form:, user_data:, **)
        return if user_form.validate(user_data)

        raise CustomError.new(error: :argument_error, status: :unprocessable_entity,
                              message: user_form.errors.to_hash)
      end

      def update_user(_ctx, user_form:, **)
        user_form.save
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
