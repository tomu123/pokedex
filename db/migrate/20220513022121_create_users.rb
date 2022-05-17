class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :given_name, null: false
      t.string :family_name, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
