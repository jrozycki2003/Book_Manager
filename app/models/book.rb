class Book < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy

  enum :status, { read: 0, unread: 1 }

  validates :title, presence: true
  validates :author, presence: true
  validates :user_id, presence: true
  validates :rating, inclusion: { in: 0..5 }, allow_nil: true

  scope :by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
  scope :by_author, ->(author) { where("author ILIKE ?", "%#{author}%") }
  scope :by_genre, ->(genre) { where(genre: genre) }
  scope :by_status, ->(status) { where(status: status) }
  scope :favorites, -> { where(favorite: true) }
  scope :rated, -> { where("rating > 0") }
  scope :top_rated, -> { order(rating: :desc) }

  def self.search(query)
    if query.present?
      by_title(query).or(by_author(query))
    else
      all
    end
  end

  def status_pl
    case status
    when 'read'
      'Przeczytane'
    when 'unread'
      'Nieprzeczytane'
    else
      status
    end
  end

  def rating_stars
    '⭐' * rating
  end

  def cover_image
    '/book.png'
  end
end
