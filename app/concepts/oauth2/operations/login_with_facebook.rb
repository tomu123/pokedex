# frozen_string_literal: true

module Oauth2
  module Operations
    class LoginWithFacebook < Trailblazer::Operation
      step :fetch_user_data
      step :fetch_email
      step :find_user
      fail :create_user, Output(:success) => End(:success)

      def fetch_user_data(ctx, access_token:, **)
        ctx[:user_data] = FacebookUserData.call(access_token)
      end

      def fetch_email(ctx, user_data:, **)
        ctx[:user_data]['email'] ||= "#{user_data['id']}@facebook.com"
      end

      def find_user(ctx, user_data:, **)
        ctx[:user] = User.find_by(email: user_data['email'])
      end

      def create_user(_ctx, user_data:, **)
        User::Operations::Create.call(user_data: { email: user_data['email'],
                                                   given_name: user_data['first_name'],
                                                   family_name: user_data['last_name'] })
      end
    end
  end
end
