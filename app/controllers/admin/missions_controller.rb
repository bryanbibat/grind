module Admin
  class MissionsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_admin
    def index
      @missions = Mission.all
    end

    def new
      @mission = Mission.new
    end

    def create
      @mission = Mission.new(params[:mission])
      if @mission.save
        redirect_to admin_missions_path, :notice => "Mission successfully created"
      else
        render "new"
      end
    end

    def edit
      @mission = Mission.find(params[:id])
    end

    def update
      @mission = Mission.find(params[:id])
      if @mission.update_attributes(params[:mission])
        redirect_to admin_missions_path, :notice => "Mission successfully updated"
      else
        render "edit"
      end
    end
  end
end
