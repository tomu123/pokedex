class Api::V1::Trainer::PokemonsController < Api::V1::Trainer::ApplicationController
  # GET /api/v1/trainer/pokemons
  def index
    result = Pokemon::Operations::Search.call(current_user: @current_user, items: params[:items], page: params[:page],
                                              query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/trainer/pokemons/1
  def show
    result = Pokemon::Operations::Show.call(pokemon_id: params[:id])
    render json: result[:json], status: :ok
  end

  # POST /api/v1/trainer/pokemons/1/capture
  def capture
    result = Pokemon::Operations::Capture.call(pokemon_id: params[:id], current_user: @current_user)
    render json: result[:json], status: :created
  end
end
