class CreateCapturedPokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :captured_pokemons do |t|
      t.string :name, null: false
      t.integer :hp, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :special_attack, null: false
      t.integer :special_defense, null: false
      t.integer :speed, null: false
      t.references :pokemon, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :deleted_at

      t.timestamps
    end
  end
end
