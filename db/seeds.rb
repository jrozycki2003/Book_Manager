# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Tagging.delete_all
Book.delete_all
Tag.delete_all
User.delete_all

# Create users
admin = User.create!(
  name: "Admin",
  email: "admin@bookmanager.com",
  password: "password123",
  role: :admin
)

user1 = User.create!(
  name: "Jan Kowalski",
  email: "jan@example.com",
  password: "password123",
  role: :user
)

user2 = User.create!(
  name: "Janina Nowak",
  email: "janina@example.com",
  password: "password123",
  role: :user
)

# Create tags
fikcja = Tag.create!(name: "Fikcja")
klasyka = Tag.create!(name: "Klasyka")
tajemnica = Tag.create!(name: "Tajemnica")
science_fiction = Tag.create!(name: "Science Fiction")
fantasy = Tag.create!(name: "Fantasy")
romans = Tag.create!(name: "Romans")

# Create books for user1
books_user1 = [
  { title: "1984", author: "George Orwell", genre: "Dystopia", status: :read, tags: [ klasyka, fikcja ] },
  { title: "To Kill a Mockingbird", author: "Harper Lee", genre: "Klasyka", status: :read, tags: [ klasyka, fikcja ] },
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", genre: "Klasyka", status: :unread, tags: [ klasyka, romans ] },
  { title: "Dune", author: "Frank Herbert", genre: "Science Fiction", status: :read, tags: [ science_fiction, fantasy ] },
  { title: "The Hobbit", author: "J.R.R. Tolkien", genre: "Fantasy", status: :unread, tags: [ fantasy, klasyka ] }
]

books_user1.each do |book_data|
  tags = book_data.delete(:tags)
  book = user1.books.create!(book_data)
  tags.each { |tag| book.taggings.create!(tag: tag) }
end

# Create books for user2
books_user2 = [
  { title: "The Girl with the Dragon Tattoo", author: "Stieg Larsson", genre: "Tajemnica", status: :read, tags: [ tajemnica, fikcja ] },
  { title: "Sherlock Holmes: A Study in Scarlet", author: "Arthur Conan Doyle", genre: "Tajemnica", status: :read, tags: [ tajemnica, klasyka ] },
  { title: "Foundation", author: "Isaac Asimov", genre: "Science Fiction", status: :unread, tags: [ science_fiction, fikcja ] },
  { title: "Pride and Prejudice", author: "Jane Austen", genre: "Romans", status: :read, tags: [ romans, klasyka ] },
  { title: "The Silent Patient", author: "Alex Michaelides", genre: "Thriller", status: :unread, tags: [ tajemnica, fikcja ] }
]

books_user2.each do |book_data|
  tags = book_data.delete(:tags)
  book = user2.books.create!(book_data)
  tags.each { |tag| book.taggings.create!(tag: tag) }
end

puts "pomyslnie utworzono dane startowe"
