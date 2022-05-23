class Api::V1::Admin::UsersController < Api::V1::Admin::ApplicationController
  # GET /api/v1/admin/users
  def index
    result = User::Operations::Search.call(current_user: @current_user, items: params[:items], page: params[:page],
                                           filter: params[:filter], query: params[:q])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/admin/users/1
  def show
    result = User::Operations::Show.call(user_id: params[:id])
    render json: result[:json], status: :ok
  end

  # POST /api/v1/admin/users
  def create
    result = User::Operations::Create.call(user_data: params.require(:data))
    render json: result[:json], status: :created, location: api_v1_admin_user_url(result[:user])
  end

  # PATCH/PUT /api/v1/admin/users/1
  def update
    result = User::Operations::Update.call(user_id: params[:id],
                                           user_data: params.require(:data))
    render json: result[:json], status: :ok
  end

  # DELETE /api/v1/admin/users/1
  def destroy
    User::Operations::Destroy.call(user_id: params[:id])
    head :no_content
  end
end
