require "rails_helper"

RSpec.describe CapturedPokemonMailer, type: :mailer do
  include_context 'Application'
  describe "captured_pokemon_notification" do
    let(:mail) do
      CapturedPokemonMailer.with(captured_pokemon_id: captured_pokemon.id,
                                 user_id: trainer.id).captured_pokemon_notification
    end

    it "renders the headers" do
      expect(mail.subject).to eq("New Captured Pokemon Notification")
      expect(mail.to).to eq([trainer.email])
      expect(mail.from).to eq(["tkomatsu@applaudostudios.dev"])
    end
  end
end
