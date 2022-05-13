class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.string :name, null: false
      t.integer :accuracy, null: false
      t.integer :effect_chance, null: false
      t.integer :power, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
