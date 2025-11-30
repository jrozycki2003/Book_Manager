class BooksController < ApplicationController
  require "csv"

  before_action :require_user
  before_action :set_book, only: [ :show, :edit, :update, :destroy, :toggle_status ]
  before_action :require_owner_or_admin, only: [ :edit, :update, :destroy, :toggle_status ]

  def index
    @search_query = params[:q]
    @genre_filter = params[:genre]
    @status_filter = params[:status]

    @books = current_user.books
    @books = @books.search(@search_query) if @search_query.present?
    @books = @books.by_genre(@genre_filter) if @genre_filter.present?
    @books = @books.by_status(@status_filter) if @status_filter.present?

    # Handle export
    if params[:format].in?([ "csv", "json" ])
      return export_books(@books)
    end

    @books = @books.page(params[:page]).per(10)

    @genres = Book.distinct.pluck(:genre).compact
  end

  def show
  end

  def new
    @book = current_user.books.build
    @genres = Book.distinct.pluck(:genre).compact.sort
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      handle_tags(@book)
      redirect_to @book, notice: "Pomyślnie dodano książkę"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @genres = Book.distinct.pluck(:genre).compact.sort
  end

  def update
    if @book.update(book_params)
      handle_tags(@book)
      redirect_to @book, notice: "Pomyślnie zaktualizowano książkę"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Pomyślnie usunięto książkę"
  end

  def toggle_status
    @book.status = @book.read? ? :unread : :read
    @book.save
    redirect_to @book, notice: "Pomyślnie zaktualizowano status książki"
  end

  def export
    @books = current_user.books
    case params[:format]
    when "csv"
      send_csv(@books)
    when "json"
      send_json(@books)
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :status, :rating, :review, :read_date, :favorite)
  end

  def handle_tags(book)
    tags_param = params[:book][:tags]
    if tags_param.present?
      tag_names = tags_param.split(",").map(&:strip).reject(&:blank?)
      book.taggings.destroy_all
      tag_names.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        book.taggings.create(tag: tag)
      end
    end
  end

  def export_books(books)
    case params[:format]
    when "csv"
      send_csv(books)
    when "json"
      send_json(books)
    end
  end

  def send_csv(books)
    csv_data = CSV.generate do |csv|
      csv << [ "Title", "Author", "Genre", "Status", "Tags" ]
      books.each do |book|
        tags = book.tags.pluck(:name).join("; ")
        csv << [ book.title, book.author, book.genre, book.status, tags ]
      end
    end
    send_data csv_data, filename: "books_#{Date.today}.csv", type: "text/csv"
  end

  def send_json(books)
    json_data = books.includes(:tags).map do |book|
      {
        title: book.title,
        author: book.author,
        genre: book.genre,
        status: book.status,
        tags: book.tags.pluck(:name)
      }
    end
    send_data json_data.to_json, filename: "books_#{Date.today}.json", type: "application/json"
  end
end
