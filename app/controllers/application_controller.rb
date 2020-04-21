class ApplicationController < ActionController::Base
  helper_method :owner_logged_in?

  def ensure_owner_logged_in
    unless session[:owner_id] && Owner.find(session[:owner_id])
      flash[:error] = 'You must a logged in owner to perform that action'
      redirect_to root_url
    end
  end

  def owner_logged_in?
    !session[:owner_id].nil?
  end
end
