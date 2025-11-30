class UsersController < ApplicationController
  def new
    redirect_to root_path if user_signed_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Pomyślnie zarejestrowano"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @books_count = @user.books.count
    @read_books_count = @user.books.read.count
    @unread_books_count = @user.books.unread.count
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Brak dostępu" unless current_user.id == @user.id
    @all_genres = Book.distinct.pluck(:genre).compact.sort
  end

  def update
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Brak dostępu" unless current_user.id == @user.id
    
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profil zaktualizowany"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def books
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).per(10)
    @genres = Book.distinct.pluck(:genre).compact
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, favorite_genres: [])
  end
end
