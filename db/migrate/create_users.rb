class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :role, default: 1, null: false # 0: admin, 1: user

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
