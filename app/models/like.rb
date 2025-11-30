class Like < ApplicationRecord
  # Relacje
  belongs_to :user      # Lajk dany przez użytkownika
  belongs_to :post      # Lajk do wpisu

  # Walidacje
  validates :user_id, presence: true      # Lajk musi mieć autora
  validates :post_id, presence: true      # Lajk musi być przywiązany do wpisu
  # Każdy użytkownik może polubić dany wpis tylko raz (unikatowość zakresu)
  validates :user_id, uniqueness: { scope: :post_id, message: "może polubić post tylko raz" }
end
