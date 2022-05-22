class PokemonMailer < ApplicationMailer
  layout false
  def new_pokemon_notification
    @users = User.trainer_role.where.not(email: nil)
    @pokemon = Pokemon.find_by(id: params[:pokemon_id])
    return if @pokemon.blank?

    mail(to: @users.pluck(:email), subject: 'New Pokemon Notification')
  end
end
