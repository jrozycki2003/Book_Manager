class CommentsController < ApplicationController
  # Komentarze mogą dodawać i usuwać tylko zalogowani użytkownicy
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Komentarz dodany"
    else
      redirect_to post_path(@post), alert: "Błąd przy dodawaniu komentarza"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    # Tylko autor komentarza lub admin mogą go usunąć
    redirect_to root_path, alert: "Brak dostępu" unless current_user.id == @comment.user_id || current_user.admin?

    @comment.destroy
    redirect_to post_path(@post), notice: "Komentarz usunięty"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
