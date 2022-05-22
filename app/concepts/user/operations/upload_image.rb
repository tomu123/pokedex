# frozen_string_literal: true

class User
  module Operations
    class UploadImage < Trailblazer::Operation
      pass :attach_image
      pass :find_user
      pass :render_json

      def attach_image(_ctx, user:, user_image:, **)
        return if user_image.blank?

        if user.image.attached?
          user.image.variant(resize_to_limit: [220, 220]).image.purge if user.image.variant(resize_to_limit: [
                                                                                              220, 220
                                                                                            ]).image&.attached?
          user.image.purge
        end
        user.image.attach(io: user_image.tempfile, filename: "user_#{user.id}.jpg")
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
