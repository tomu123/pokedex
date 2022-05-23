class Api::V1::Trainer::CapturedPokemonsController < Api::V1::Trainer::ApplicationController
  # GET /api/v1/trainer/captured_pokemons
  def index
    result = CapturedPokemon::Operations::Search.call(current_user: @current_user, items: params[:items],
                                                      filter: params[:filter], page: params[:page], query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/trainer/captured_pokemons/1
  def show
    result = CapturedPokemon::Operations::Show.call(captured_pokemon_id: params[:id])
    render json: result[:json], status: :ok
  end

  # PATCH/PUT /api/v1/trainer/captured_pokemons/1
  def update
    result = CapturedPokemon::Operations::Update.call(captured_pokemon_id: params[:id],
                                                      captured_pokemon_data: params[:data])
    render json: result[:json], status: :ok
  end

  # DELETE /api/v1/trainer/captured_pokemons/1
  def destroy
    CapturedPokemon::Operations::Destroy.call(captured_pokemon_id: params[:id])
    head :no_content
  end
end
