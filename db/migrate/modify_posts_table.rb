class ModifyPostsTable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :posts, :book_id, true
    remove_column :posts, :title, :string
  end
end
