class Api::V1::Trainer::UsersController < Api::V1::Trainer::ApplicationController
  def upload_image
    result = User::Operations::UploadImage.call(user: @current_user, user_image: params[:image])
    render json: result[:json], status: :ok
  end

  # GET /api/v1/trainer/users/1
  def show
    result = User::Operations::Show.call(user_id: @current_user.id)
    render json: result[:json], status: :ok
  end
end
