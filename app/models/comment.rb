class Comment < ApplicationRecord
  # Relacje
  belongs_to :user      # Komentarz napisany przez użytkownika
  belongs_to :post      # Komentarz przywiązany do wpisu

  # Walidacje
  validates :content, presence: true      # Komentarz musi mieć zawartość
  validates :user_id, presence: true      # Komentarz musi mieć autora
  validates :post_id, presence: true      # Komentarz musi być przywiązany do wpisu
end
