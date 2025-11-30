class SessionsController < ApplicationController
  def new
    redirect_to root_path if user_signed_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Zalogowano pomyślnie"
    else
      flash.now[:alert] = "Email lub hasło są nieprawidłowe"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Wylogowano pomyślnie"
  end
end
