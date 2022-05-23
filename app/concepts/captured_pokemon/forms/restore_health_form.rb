# frozen_string_literal: true

class CapturedPokemon
  module Forms
    class RestoreHealthForm < Reform::Form
      property :hp

      validates :hp, presence: true
      validates :hp, numericality: { only_integer: true }
      validate :valid_hp?

      private

      def valid_hp?
        return unless hp.present? && model.hp > hp

        errors.add(:hp, "Restored Health can not lower than Current HP of captured pokemon")
      end
    end
  end
end
