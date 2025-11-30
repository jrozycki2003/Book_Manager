class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :genre
      t.integer :status, default: 1, null: false # 0: read, 1: unread
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :books, [:user_id, :title]
  end
end
