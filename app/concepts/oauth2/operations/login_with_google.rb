# frozen_string_literal: true

module Oauth2
  module Operations
    class LoginWithGoogle < Trailblazer::Operation
      step :fetch_user_data
      step :find_user
      fail :create_user, Output(:success) => End(:success)

      def fetch_user_data(ctx, access_token:, **)
        ctx[:user_data] = GoogleUserData.call(access_token)
      end

      def find_user(ctx, user_data:, **)
        ctx[:user] = User.find_by(email: user_data['emails'][0]['value'])
      end

      def create_user(_ctx, user_data:, **)
        User::Operations::Create.call(user_data: { email: user_data['emails'][0]['value'],
                                                   given_name: user_data['name']['givenName'],
                                                   family_name: user_data['name']['familyName'] })
      end
    end
  end
end
