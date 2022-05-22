# frozen_string_literal: true

class User
  module Operations
    class Create < Trailblazer::Operation
      step :create_user_form
      step :validate_form
      fail :invalid_user_form, fail_fast: true
      step :create_user
      step :find_user
      step :render_json

      def create_user_form(ctx, user_data:, **)
        ctx[:user_form] = User::Forms::User.new(**user_data)
      end

      def validate_form(_ctx, user_form:, **)
        user_form.valid?
      end

      def invalid_user_form(_ctx, user_form:, **)
        raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: user_form.errors.to_hash)
      end

      def create_user(ctx, user_data:, **)
        ctx[:user] = User.create(user_data)
      end

      def find_user(ctx, user:, **)
        ctx[:user] = User.includes(pokemons: %i[region types moves]).find(user.id)
      end

      def render_json(ctx, user:, **)
        ctx[:json] = User::Representers::User.jsonapi_new(user).to_json
      end
    end
  end
end
