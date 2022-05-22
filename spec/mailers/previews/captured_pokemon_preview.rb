# Preview all emails at http://localhost:3000/rails/mailers/captured_pokemon
class CapturedPokemonPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/captured_pokemon/captured_pokemon_notification
  def captured_pokemon_notification
    CapturedPokemonMailer.with(captured_pokemon_id: CapturedPokemon.last.id,
                               user_id: User.last.id).captured_pokemon_notification
  end
end
