class OwnerController < ApplicationController
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      flash[:success] = 'You are ready to rock!'
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def owner_params
    params.require(:owner).permit(
      :name,
      :email,
      :location,
      :about,
      :profile_image,
      :github,
      :linkedin
    )
  end
end
