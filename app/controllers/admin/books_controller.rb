class Admin::BooksController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def index
    @books = Book.includes(:user).page(params[:page]).per(20)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path, notice: "Pomyślnie usunięto książkę"
  end
end
