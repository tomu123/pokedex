class Api::V1::Doctor::CapturedPokemonsController < Api::V1::Doctor::ApplicationController
  # GET /api/v1/doctor/user/:user_id/captured_pokemons
  def index
    result = CapturedPokemon::Operations::Search.call(current_user: @current_user, items: params[:items],
                                                      filter: params[:filter], page: params[:page],
                                                      trainer_id: params[:user_id], query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/doctor/captured_pokemons/1
  def show
    result = CapturedPokemon::Operations::Show.call(current_user: @current_user, captured_pokemon_id: params[:id])
    render json: result[:json], status: :ok
  end

  # PATCH /api/v1/doctor/captured_pokemons/1/restore_health
  def restore_health
    result = CapturedPokemon::Operations::RestoreHealth.call(captured_pokemon_id: params[:id],
                                                             captured_pokemon_data: params.require(:data))
    render json: result[:json], status: :ok
  end
end
