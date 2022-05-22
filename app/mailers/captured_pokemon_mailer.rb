class CapturedPokemonMailer < ApplicationMailer
  layout false
  def captured_pokemon_notification
    @user = User.find_by(id: params[:user_id])
    @captured_pokemon = CapturedPokemon.includes(pokemon: %i[region types
                                                             moves]).find_by(id: params[:captured_pokemon_id])
    return if @captured_pokemon.blank? || @user.blank?

    mail(to: @user.email, subject: 'New Captured Pokemon Notification')
  end
end
