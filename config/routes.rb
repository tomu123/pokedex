Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :trainer do
        resources :pokemons, only: [:index,:show] do
          post 'capture', on: :member
        end
        resource :user, only: [:show] do
          patch 'upload_image'
        end
      end
    end
  end
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
