class Post < ApplicationRecord
  # Relacje
  belongs_to :user
  # Wpis może być przywiązany do książki (opcjonalnie) lub ogólnym wpisem na forum
  belongs_to :book, optional: true
  # Usunięcie wpisu usunie wszystkie jego komentarze
  has_many :comments, dependent: :destroy
  # Usunięcie wpisu usunie wszystkie lajki
  has_many :likes, dependent: :destroy

  # Walidacje
  validates :content, presence: true  # Wpis musi mieć zawartość
  validates :user_id, presence: true  # Wpis musi mieć autora
end
