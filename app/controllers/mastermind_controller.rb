class MastermindController < ApplicationController
  before_action :check_owner

  def base
    @owner = Owner.first
    @projects = Project.active_projects
  end

  private

  def check_owner
    unless Owner.first
      redirect_to new_owner_url
    end
  end
end
