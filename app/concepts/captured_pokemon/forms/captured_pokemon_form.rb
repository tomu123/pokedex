# frozen_string_literal: true

class CapturedPokemon
  module Forms
    class CapturedPokemonForm < Reform::Form
      property :name
      property :hp
      property :attack
      property :defense
      property :special_attack
      property :special_defense
      property :speed
      property :user, parse: false

      validates :name, :hp, :attack, :defense, :special_attack, :special_defense, :speed,
                :user, presence: true
      validates :hp, :attack, :defense, :special_attack, :special_defense, :speed, numericality: { only_integer: true }
      validate :max_captured_pokemon?

      private

      def max_captured_pokemon?
        errors.add(:user, "5 captured pokemons is the maximun allowed") unless user.captured_pokemons.size < 5
      end
    end
  end
end
