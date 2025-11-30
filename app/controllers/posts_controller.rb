class PostsController < ApplicationController
  # Wymaga logowania oprócz wyświetlania listy i szczegółów wpisów
  before_action :require_user, except: [ :index, :show ]
  # Pobierz książkę tylko przy tworzeniu wpisu związanego z książką
  before_action :set_book, only: [ :new, :create ]
  # Pobierz wpis dla akcji show i destroy
  before_action :set_post, only: [ :show, :destroy ]

  def index
    @posts = Post.includes(:user, :book, :likes, :comments).order(created_at: :desc)
  end

  def new
    if @book
      # Tylko właściciel książki, która została przeczytana, może tworzyć wpis
      redirect_to root_path, alert: "Brak dostępu" unless @book.user_id == current_user.id && @book.read?
      @post = @book.posts.build
    else
      # Wpis ogólny na forum bez przywiązania do konkretnej książki
      @post = Post.build
    end
  end

  def create
    # Jeśli wpis jest związany z książką, sprawdź czy użytkownik jest właścicielem i czy przeczytał książkę
    if params[:book_id].present?
      redirect_to root_path, alert: "Brak dostępu" unless @book.user_id == current_user.id && @book.read?
      @post = @book.posts.build(post_params)
    else
      # Wpis ogólny na forum bez przywiązania do konkretnej książki
      @post = Post.build(post_params)
    end

    # Przypisz bieżącego użytkownika jako autora wpisu
    @post.user = current_user

    if @post.save
      redirect_to posts_path, notice: "Post opublikowany"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comments = @post.comments.includes(:user).order(created_at: :asc)
    @comment = @post.comments.build
  end

  def destroy
    # Tylko admin i autor wpisu mogą go usunąć
    redirect_to root_path, alert: "Brak dostępu" unless current_user.admin? || current_user.id == @post.user_id
    @post.destroy
    redirect_to posts_path, notice: "Post usunięty"
  end

  private

  def set_book
    @book = Book.find(params[:book_id]) if params[:book_id].present?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
