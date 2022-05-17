# frozen_string_literal: true

module ThirdPartyAuthentication
  class LoginWithGoogle < ThirdPartyAuthentication::LoginWith3rdParty
    def initialize(access_token)
      super(access_token)
      @api_endpoint = ENV.fetch('GOOGLE_USER_DATA_ENDPOINT')
    end

    def transform_user_data
      @user_data = {
        id: @user_data['id'],
        email: @user_data['emails'][0]['value'],
        given_name: @user_data['name']['givenName'],
        family_name: @user_data['name']['familyName']
      }
    end
  end
end
