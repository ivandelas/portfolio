class OwnerController < ApplicationController
  before_action :set_owner, only: [:edit, :update]

  def edit
  end

  def update
    if @owner.update(owner_params)
      if owner_params[:profile_image]
        @owner.profile_image.purge
        @owner.profile_image.attach(owner_params[:profile_image])
      end

      flash[:success] = 'Your profile has been updated'
    else
      flash[:error] = 'Your profile could not be updated'
    end

    redirect_to root_url
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      @owner.profile_image.attach(owner_params[:profile_image])

      unless @owner.profile_image.attached?
        @owner.profile_image.attach(
          io: File.open(
            Rails.root.join('app', 'assets', 'images', 'profile.png')),

          filename: 'profile.png',
          content_type: 'image/png'
        )
      end

      flash[:success] = 'You are ready to rock!'
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def set_owner
    unless @owner = Owner.first
      flash[:error] = 'There is no owner for the application'
      redirect_to new_owner_url
    end
  end

  def owner_params
    params.require(:owner).permit(
      :name,
      :email,
      :location,
      :about,
      :github,
      :linkedin,
      :profile_image
    )
  end
end
