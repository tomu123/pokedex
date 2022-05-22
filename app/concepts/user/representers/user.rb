# frozen_string_literal: true

class User
  module Representers
    class User < Application::Representers::ApplicationRepresenter
      property :id
      property :email
      property :given_name
      property :family_name
      property :user_role
      property :image, exec_context: :decorator
      collection :captured_pokemons, decorator: CapturedPokemon::Representers::CapturedPokemon
      def image
        return nil unless represented.image.attached?

        Rails.application.routes.url_helpers.url_for(represented.image.variant(resize_to_limit: [220, 220]))
      end
    end
  end
end
