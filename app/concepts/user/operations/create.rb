# frozen_string_literal: true

class User
  module Operations
    class Create < Trailblazer::Operation
      pass :create_user_form
      pass :validate_form
      pass :create_user
      pass :attach_image
      pass :find_user
      pass :render_json

      def create_user_form(ctx, **)
        ctx[:user] = User.new
        ctx[:user_form] = User::Forms::UserForm.new(ctx[:user])
      end

      def validate_form(_ctx, user_form:, user_data:, **)
        return if user_form.validate(user_data)

        raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: user_form.errors.to_hash)
      end

      def create_user(_ctx, user_form:, **)
        user_form.save
      end

      def attach_image(_ctx, user:, user_data:, **)
        return if user_data[:user_image].blank?

        user.image.attach(io: URI.parse(user_data[:user_image]).open, filename: "user_#{user.id}.jpg")
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
