class MissionsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @missions = Mission.available_missions(current_user)    
  end

  def show
    @mission = Mission.find(params[:id])
  end

  def perform
    @mission = Mission.find(params[:id])
    if @mission.can_be_performed_by_user current_user
      if @mission.attempt current_user
        flash[:mission_messages] = @mission.mission_messages.join("\n")
        redirect_to @mission
      else
        flash[:mission_errors] = @mission.mission_errors.join("\n")
        redirect_to @mission
      end
    else
      flash.now[:alert] = @mission.mission_errors
      render "show"
    end
  end

end
