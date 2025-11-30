class DashboardController < ApplicationController
  before_action :require_user

  def index
    @user = current_user
    @total_books = @user.books.count
    @read_books = @user.books.read.count
    @unread_books = @user.books.unread.count
    @recent_books = @user.books.order(created_at: :desc).limit(5)
    @genres = @user.books.group(:genre).count
    @genre_counts = @genres.reject { |k, v| k.nil? }
  end
end
