# frozen_string_literal: true

class FacebookUserData
  def self.call(access_token)
    conn = Faraday.new(
      url: ENV.fetch('FACEBOOK_USER_DATA_ENDPOINT'),
      params: { fields: 'id,first_name,last_name,email' },
      headers: { 'Content-Type' => 'application/json' }
    )
    response = conn.get('', { access_token: access_token })
    raise StandardError, JSON.parse(response.body)['error']['message'] unless response.success?

    JSON.parse(response.body)
  end
end
