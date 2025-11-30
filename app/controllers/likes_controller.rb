class LikesController < ApplicationController
  # Lajki mogą dodawać i usuwać tylko zalogowani użytkownicy
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    # Nowy lajk przywiązany do bieżącego użytkownika
    @like = @post.likes.build(user: current_user)

    # Jeśli lajk jest duplikatem (użytkownik już polubił), walidacja zwróci błąd
    if @like.save
      redirect_to posts_path, notice: "Polubiono"
    else
      redirect_to posts_path, alert: "Już polubiłeś ten post"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    # Tylko użytkownik który dał lajka może go usunąć
    redirect_to root_path, alert: "Brak dostępu" unless current_user.id == @like.user_id

    @like.destroy
    redirect_to posts_path, notice: "Lajk usunięty"
  end
end
