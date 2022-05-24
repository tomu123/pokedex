class Api::V1::Trainer::TypesController < Api::V1::Trainer::ApplicationController
  # GET /api/v1/trainer/types
  def index
    result = Type::Operations::Search.call(current_user: @current_user, items: params[:items], page: params[:page],
                                           query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/trainer/types/1
  def show
    result = Type::Operations::Show.call(type_id: params[:id])
    render json: result[:json], status: :ok
  end
end
