class ResearchProjectsController < ApplicationController
  def index
    @research_projects = current_user.research_progresses.order :completed
  end

  def perform
    if current_user.energy > 0
      current_user.energy -= 1
      cur_project = current_user.research_progresses.find(params[:id])
      cur_project.progress += current_user.effective_cunning
      cur_project.save
      current_user.save
      redirect_to research_projects_path
    else
      flash.now[:alert] = "You do not have enough energy"
      render "index"
    end
  end
end
