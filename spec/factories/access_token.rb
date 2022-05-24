FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    application { client_app }
    expires_in { 2.hours }
    scopes { '' }
  end
end
