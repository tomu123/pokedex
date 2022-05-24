require "rails_helper"

RSpec.describe PokemonMailer, type: :mailer do
  include_context 'Application'
  describe "new_pokemon_notification" do
    let(:mail) { PokemonMailer.with(pokemon_id: pokemon.id).new_pokemon_notification }

    it "renders the headers" do
      rand(1..5).times do
        create(:user)
      end
      expect(mail.subject).to eq("New Pokemon Notification")
      expect(mail.to).to eq(User.trainer_role.pluck(:email))
      expect(mail.from).to eq(["tkomatsu@applaudostudios.dev"])
    end
  end
end
