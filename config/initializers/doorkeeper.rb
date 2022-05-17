# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  orm :active_record

  base_controller 'ApplicationController'
  base_metal_controller 'ApplicationController'

  # enable grant flows
  grant_flows %w[assertion]

  allow_blank_redirect_uri true

  skip_authorization do
    true
  end

  use_refresh_token

  resource_owner_from_assertion do
    result = Oauth2::Operations::LoginWith3rdParty.call(provider: params[:provider], access_token: params[:access_token])
    result[:user]
  end
end
