class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :user_signed_in?

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def require_user
    redirect_to new_session_path, alert: "Musisz być zalogowany" unless user_signed_in?
  end

  def require_admin
    redirect_to root_path, alert: "Brak dostępu" unless current_user&.admin?
  end

  def require_owner_or_admin
    @book = Book.find(params[:id])
    redirect_to books_path, alert: "Brak dostępu" unless current_user&.admin? || @book.user_id == current_user&.id
  end
end
