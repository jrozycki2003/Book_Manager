class User < ApplicationRecord
  has_secure_password
  has_many :books, dependent: :destroy
  has_many :taggings, through: :books
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum :role, { admin: 0, user: 1 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  before_save :serialize_favorite_genres

  scope :regular_users, -> { where(role: :user) }
  scope :admins, -> { where(role: :admin) }

  def profile_image
    '/profile.png'
  end

  private

  def serialize_favorite_genres
    if favorite_genres.is_a?(Array)
      self.favorite_genres = favorite_genres.reject(&:blank?).join(', ')
    elsif favorite_genres.is_a?(String)
      # Jeśli jest już string, usuwamy nawiasy kwadratowe jeśli istnieją
      self.favorite_genres = favorite_genres.gsub(/[\[\]]/, '').gsub('"', '').strip
    end
  end
end
