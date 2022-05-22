Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :doctor do
        resources :pokemons
      end
    end
  end
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
