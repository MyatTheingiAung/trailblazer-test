class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :phone
      t.string :address
      t.date :birthday
      t.string :role, null: false

      t.timestamps
    end
  end
end
