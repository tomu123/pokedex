# frozen_string_literal: true

class CapturedPokemon
  module Representers
    class CapturedPokemon < Application::Representers::ApplicationRepresenter
      property :id
      property :name
      property :hp
      property :attack
      property :defense
      property :special_attack
      property :special_defense
      property :speed
      property :created_at, as: :captured_at

      property :pokemon, as: :species do
        property :height
        property :weight
        property :description
        property :image, exec_context: :decorator
        collection :types do
          property :name
        end

        property :region do
          property :name
        end

        collection :moves do
          property :id
          property :name
          property :accuracy
          property :effect_chance
          property :power
          property :description
        end
        def image
          p represented
          return nil unless represented.image.attached?

          Rails.application.routes.url_helpers.url_for(represented.image.variant(resize_to_limit: [220, 220]))
        end
      end
    end
  end
end
