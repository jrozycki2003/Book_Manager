class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :book

  validates :tag_id, uniqueness: { scope: :book_id }
end
