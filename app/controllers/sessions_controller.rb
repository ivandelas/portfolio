class SessionsController < ApplicationController
  def login
  end

  def create
    owner = Owner.first
    email_is_valid = owner.email == session_params[:email]
    password_is_valid = owner.authenticate(session_params[:password])

    if email_is_valid && password_is_valid
      session[:owner_id] = owner.id
      flash[:success] = 'You are logged in'
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid credentials'
      render :login
    end
  end

  def destroy
    flash[:info] = 'You just logged out'
    session.delete(:owner_id)
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
