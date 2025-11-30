class Admin::UsersController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @books_count = @user.books.count
    @read_books_count = @user.books.read.count
    @unread_books_count = @user.books.unread.count
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to admin_users_path, alert: "Nie możesz usunąć siebie" if @user == current_user
    @user.destroy
    redirect_to admin_users_path, notice: "Pomyślnie usunięto użytkownika"
  end
end
