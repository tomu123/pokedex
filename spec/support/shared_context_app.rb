RSpec.shared_context "Application" do
  let(:trainer) { FactoryBot.create(:user, user_role: 'trainer') }
  let(:doctor) { FactoryBot.create(:user, user_role: 'doctor') }
  let(:admin) { FactoryBot.create(:user, user_role: 'admin') }
  let(:type) { FactoryBot.create(:type) }
  let(:pokemon) { FactoryBot.create(:pokemon, types: [type]) }
  let(:captured_pokemon) { FactoryBot.create(:captured_pokemon, pokemon: pokemon, user: trainer) }
  let(:client_app) { FactoryBot.create(:client_app) }
  let(:access_token_trainer) do
    FactoryBot.create(:access_token, application: client_app, resource_owner_id: trainer.id)
  end
  let(:access_token_doctor) { FactoryBot.create(:access_token, application: client_app, resource_owner_id: doctor.id) }
  let(:access_token_admin) { FactoryBot.create(:access_token, application: client_app, resource_owner_id: admin.id) }
  let(:valid_headers_trainer) do
    { Authorization: "Bearer #{access_token_trainer.token}", 'Content-Type': "application/vnd.api+json" }
  end
  let(:invalid_headers_trainer) do
    { Authorization: "Bearer #{access_token_doctor.token}", 'Content-Type': "application/vnd.api+json" }
  end
end
