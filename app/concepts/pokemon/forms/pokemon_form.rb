# frozen_string_literal: true

class Pokemon
  module Forms
    class PokemonForm < Reform::Form
      property :name
      property :height
      property :weight
      property :hp
      property :attack
      property :defense
      property :special_attack
      property :special_defense
      property :speed
      property :description
      property :type_ids
      property :region_id
      property :move_ids

      validates :name, :height, :weight, :hp, :attack, :defense, :special_attack, :special_defense, :speed,
                :description, :region_id, presence: true
      validates :type_ids, presence: { message: "Pokemon should belong to at least one type" }
      validates :height, :weight, :hp, :attack, :defense, :special_attack, :special_defense, :speed,
                numericality: { only_integer: true }
      validate :types_valid?, :region_valid?, :moves_valid?

      private

      def types_valid?
        errors.add(:type_ids, "Must be an array of type ids") and return unless type_ids.is_a?(Array)

        type_ids.each do |type_id|
          errors.add(:type_ids, "Invalid Type ID:#{type_id}") unless Type.find_by(id: type_id)
        end
      end

      def region_valid?
        errors.add(:region_id, "Invalid Region ID:#{region_id}") unless Region.find_by(id: region_id)
      end

      def moves_valid?
        return if move_ids.blank?
        errors.add(:move_ids, "Must be an array of move ids") and return unless move_ids.is_a?(Array)

        move_ids.each do |move_id|
          errors.add(:move_ids, "Invalid Move ID:#{move_id}") unless Move.find_by(id: move_id)
        end
        errors.add(:move_ids, "4 moves is the maximum allowed") if move_ids.size > 4
      end
    end
  end
end
