require "rails_helper"

RSpec.describe CapturedPokemonMailer, type: :mailer do
  describe "captured_pokemon_notification" do
    let(:mail) { CapturedPokemonMailer.with(captured_pokemon_id: 1, user_id: 1).captured_pokemon_notification }

    it "renders the headers" do
      user = create(:user)
      pokemon = create(:pokemon)
      create(:captured_pokemon, pokemon: pokemon, user: user)
      expect(mail.subject).to eq("New Captured Pokemon Notification")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["tkomatsu@applaudostudios.dev"])
    end
  end
end
