class RemoveCoverImageFromBooks < ActiveRecord::Migration[8.1]
  def change
    remove_column :books, :cover_image, :string
  end
end
