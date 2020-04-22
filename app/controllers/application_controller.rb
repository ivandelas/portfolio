class ApplicationController < ActionController::Base
  helper_method :owner_logged_in?
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_owner

  def ensure_owner_logged_in
    unless session[:owner_id] && Owner.find(session[:owner_id])
      flash[:error] = 'You must a logged in owner to perform that action'
      redirect_to root_url
    end
  end

  def owner_logged_in?
    session[:owner_id] && Owner.first && Owner.first.id == session[:owner_id]
  end

  private

  def invalid_owner
    flash[:error] = 'You are not the owner of this portfolio'
    redirect_to root_url
  end
end
