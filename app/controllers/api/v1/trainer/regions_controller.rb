class Api::V1::Trainer::RegionsController < Api::V1::Trainer::ApplicationController
  # GET /api/v1/trainer/regions
  def index
    result = Region::Operations::Search.call(current_user: @current_user, items: params[:items], page: params[:page],
                                             query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/trainer/regions/1
  def show
    result = Region::Operations::Show.call(region_id: params[:id])
    render json: result[:json], status: :ok
  end
end
