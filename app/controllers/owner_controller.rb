class OwnerController < ApplicationController
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
