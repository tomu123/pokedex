# frozen_string_literal: true

class User
  module Operations
    class Recover < Trailblazer::Operation
      pass :set_user
      pass :recover_user

      def set_user(ctx, user_id:, **)
        ctx[:user] = User.unscoped.find(user_id)
      end

      def recover_user(_ctx, user:, **)
        user.recover
      end
    end
  end
end
