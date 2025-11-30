class AddBookDetails < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :rating, :integer, default: 0 # 0-5 gwiazdek
    add_column :books, :review, :text
    add_column :books, :cover_image, :string
    add_column :books, :read_date, :date
    add_column :books, :favorite, :boolean, default: false
  end
end
