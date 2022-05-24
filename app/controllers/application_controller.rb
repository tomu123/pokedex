class ApplicationController < ActionController::API
  include ErrorHandler

  # helper method to access the current user from the token
  def current_user
    @current_user ||= User.unscoped.find_by(id: doorkeeper_token[:resource_owner_id])
    return @current_user if @current_user.deleted_at.blank?

    raise CustomError.new(status: :forbidden, error: 'Disabled User', message: 'User has been disabled')
  end
end
