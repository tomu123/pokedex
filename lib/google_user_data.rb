# frozen_string_literal: true

class GoogleUserData
  def self.call(access_token)
    google = URI.parse("#{ENV['GOOGLE_USER_DATA_ENDPOINT']}#{access_token}")
    response = Net::HTTP.get_response(google)
    JSON.parse(response.body)
  end
end
