class CreateCapturedPokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :captured_pokemons do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :delete_at

      t.timestamps
    end
  end
end
