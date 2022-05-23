# frozen_string_literal: true

class User
  module Operations
    class Destroy < Trailblazer::Operation
      pass :set_user
      pass :destroy_user

      def set_user(ctx, user_id:, **)
        ctx[:user] = User.find(user_id)
      end

      def destroy_user(_ctx, user:, **)
        user.soft_destroy
      end
    end
  end
end
