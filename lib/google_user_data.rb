# frozen_string_literal: true

class GoogleUserData
  def self.call(access_token)
    conn = Faraday.new(
      url: ENV.fetch('GOOGLE_USER_DATA_ENDPOINT'),
      headers: { 'Content-Type' => 'application/json' }
    )
    response = conn.get('', { access_token: access_token })
    JSON.parse(response.body)
  end
end
