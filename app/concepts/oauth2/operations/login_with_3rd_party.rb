# frozen_string_literal: true

module Oauth2
  module Operations
    class LoginWith3rdParty < Trailblazer::Operation
      step :fetch_user_data
      step :find_third_party_user
      step :find_user
      fail :create_user, Output(:success) => Track(:success)
      step :save_third_party_user

      def fetch_user_data(ctx, provider:, access_token:, **)
        ctx[:user_data] = case provider
                          when 'google'
                            ThirdPartyAuthentication::LoginWithGoogle.call(access_token)
                          when 'facebook'
                            ThirdPartyAuthentication::LoginWithFacebook.call(access_token)
                          else
                            raise ArgumentError, 'Invalid Third Party Authentication Provider'
                          end
      end

      def find_third_party_user(ctx, user_data:, provider:, **)
        ctx[:third_party_user] = ThirdPartyUser.find_or_initialize_by(provider: provider, provider_id: user_data[:id])
      end

      def find_user(ctx, third_party_user:, user_data:, **)
        ctx[:user] = if user_data[:email].present?
                       User.find_by(email: user_data[:email])
                     else
                       User.find_by(third_party_user: third_party_user)
                     end
      end

      def create_user(ctx, user_data:, **)
        ctx[:user] = User::Operations::Create.call(user_data: { email: user_data[:email],
                                                                given_name: user_data[:given_name],
                                                                family_name: user_data[:family_name] })[:user]
      end

      def save_third_party_user(_ctx, user:, third_party_user:, **)
        third_party_user.user ||= user
        third_party_user.save!
      end
    end
  end
end
