class MastermindController < ApplicationController
  def base
    @owner = Owner.first
    @projects = @owner.projects
  end
end
