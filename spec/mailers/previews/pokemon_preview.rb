# Preview all emails at http://localhost:3000/rails/mailers/pokemon
class PokemonPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/pokemon/new_pokemon_notification
  def new_pokemon_notification
    PokemonMailer.with(pokemon_id: Pokemon.last.id).new_pokemon_notification
  end
end
