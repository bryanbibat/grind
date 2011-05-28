module Admin
  class LootsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_admin

    def index 
      redirect_to admin_mission_path(params[:mission_id])
    end
    
    def show
      redirect_to admin_mission_path(params[:mission_id])
    end

    def new
      @mission = Mission.find(params[:mission_id])
      @loot = @mission.loots.build
    end

    def create
      @mission = Mission.find(params[:mission_id])
      @loot = @mission.loots.build(params[:loot])
      if @loot.save
        redirect_to admin_mission_path(@mission), :notice => "Loot successfully created"
      else
        render "new"
      end
    end

    def edit
      @mission = Mission.find(params[:mission_id])
      @loot = @mission.loots.find(params[:id])
    end

    def update
      @mission = Mission.find(params[:mission_id])
      @loot = @mission.loots.find(params[:id])
      if @loot.update_attributes(params[:loot])
        redirect_to admin_mission_path(@mission), :notice => "Loot successfully updated"
      else
        render "edit"
      end
    end

  end
end
