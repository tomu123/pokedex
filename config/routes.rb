Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :users do
          patch 'recover', on: :member
        end
      end
      namespace :trainer do
        resources :pokemons, only: [:index,:show] do
          post 'capture', on: :member
        end
        resource :user, only: [:show] do
          patch 'upload_image'
        end
        resources :captured_pokemons,except: [:create]
        resources :types, only: [:index,:show]
        resources :regions, only: [:index,:show]
      end
      namespace :doctor do
        resources :pokemons
        resources :user, only: [] do
          resources :captured_pokemons, shallow: true, only: [:index,:show] do
            patch 'restore_health', on: :member
          end
        end
      end
    end
  end
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
