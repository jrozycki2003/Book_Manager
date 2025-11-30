Rails.application.routes.draw do
  # Strona główna
  root "pages#home"

  # Endpoint zdrowotności aplikacji - zwraca 200 jeśli aplikacja działa poprawnie
  get "up" => "rails/health#show", as: :rails_health_check

  # Trasy autentykacji
  get "sessions/new", to: "sessions#new", as: :new_session
  post "sessions", to: "sessions#create", as: :sessions
  delete "sessions", to: "sessions#destroy", as: :session

  # Zasoby użytkownika - z dodatkową trasą do wyświetlania książek innego użytkownika
  resources :users, only: [ :new, :create, :show, :edit, :update ] do
    get "books", on: :member, to: "users#books", as: "books"  # /users/:id/books - lista książek użytkownika
  end

  # Deska rozdzielcza użytkownika
  get "dashboard", to: "dashboard#index"

  # Trasy książek - z zagnieżdżonymi wpisami (tworzone w kontekście książki)
  resources :books do
    resources :posts, only: [ :new, :create ]  # Tworzenie wpisu przywiązanego do książki
    member do
      patch :toggle_status  # Zmiana statusu przeczytania
    end
    collection do
      get :export  # Eksport wszystkich książek użytkownika
    end
  end

  # Wpisy na forum - niezależne od książek
  resources :posts, only: [ :index, :show, :new, :create, :destroy ] do
    resources :comments, only: [ :create, :destroy ]  # Komentarze do wpisu
    resources :likes, only: [ :create, :destroy ]      # Lajki wpisu
  end

  # Trasy administracyjne - dostęp tylko dla adminów
  namespace :admin do
    resources :users, only: [ :index, :show, :destroy ]
    resources :books, only: [ :index, :destroy ]
  end
end
