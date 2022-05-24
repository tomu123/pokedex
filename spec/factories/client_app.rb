FactoryBot.define do
  factory :client_app, class: 'Doorkeeper::Application' do
    name { "Android client" }
    redirect_uri { "" }
    scopes { "" }
  end
end
