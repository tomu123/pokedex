# frozen_string_literal: true

module ThirdPartyAuthentication
  class LoginWith3rdParty
    attr_reader :api_endpoint, :params, :access_token

    def self.call(...)
      new(...).call
    end

    def initialize(access_token)
      @params = {}
      @access_token = access_token
    end

    def call
      set_connection
      fetch_response
      validate_response
      parse_json_response
      transform_user_data
    end

    private

    def set_connection
      @conn = ::CustomHttp.new(
        url: api_endpoint,
        params: params,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def fetch_response
      @response = @conn.get('', { access_token: access_token })
    end

    def validate_response
      return true if @response.success?

      raise CustomError.new(status: :unauthorized, error: 'Could not Authenticate',
                            message: JSON.parse(@response.body)['error']['message'])
    end

    def parse_json_response
      @user_data = JSON.parse(@response.body)
    end

    def transform_user_data
      @user_data
    end
  end
end
