class Api::V1::Doctor::PokemonsController < Api::V1::Doctor::ApplicationController
  # GET /api/v1/doctor/pokemons
  def index
    result = Pokemon::Operations::Search.call(current_user: @current_user, items: params[:items], page: params[:page],
                                              query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/doctor/pokemons/1
  def show
    result = Pokemon::Operations::Show.call(pokemon_id: params[:id])
    render json: result[:json], status: :ok
  end

  # POST /api/v1/doctor/pokemons
  def create
    # result = Pokemon::Operations::Create.call(pokemon_data: JSON.parse(params[:data]).with_indifferent_access)
    result = Pokemon::Operations::Create.call(pokemon_data: JSON.parse(params.require(:data)).with_indifferent_access,
                                              pokemon_image: params[:image])
    render json: result[:json], status: :created, location: api_v1_doctor_pokemon_url(result[:pokemon])
  end

  # PATCH/PUT /api/v1/doctor/pokemons/1
  def update
    result = Pokemon::Operations::Update.call(pokemon_id: params[:id],
                                              pokemon_data: JSON.parse(params.require(:data)).with_indifferent_access,
                                              pokemon_image: params[:image])
    render json: result[:json], status: :ok
  end

  # DELETE /api/v1/doctor/pokemons/1
  def destroy
    Pokemon::Operations::Destroy.call(pokemon_id: params[:id])
    head :no_content
  end
end
