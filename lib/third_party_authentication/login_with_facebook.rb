# frozen_string_literal: true

module ThirdPartyAuthentication
  class LoginWithFacebook < ThirdPartyAuthentication::LoginWith3rdParty
    def initialize(access_token)
      super(access_token)
      @api_endpoint = ENV.fetch('FACEBOOK_USER_DATA_ENDPOINT')
      @params = { fields: 'id,first_name,last_name,email,picture' }
    end

    def transform_user_data
      @user_data = {
        id: @user_data['id'],
        email: @user_data['email'],
        given_name: @user_data['first_name'],
        family_name: @user_data['last_name'],
        image: @user_data.dig('picture', 'data', 'url')
      }
    end
  end
end
