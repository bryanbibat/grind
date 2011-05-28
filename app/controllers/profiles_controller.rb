class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  def show
    redirect_to root_path
  end

  def upgrade_melee
    current_user.upgrade_melee
    redirect_to root_path
  end 

  def upgrade_ranged
    current_user.upgrade_ranged
    redirect_to root_path
  end 

  def upgrade_defense
    current_user.upgrade_defense
    redirect_to root_path
  end 

  def upgrade_agility
    current_user.upgrade_agility
    redirect_to root_path
  end

  def upgrade_cunning
    current_user.upgrade_cunning
    redirect_to root_path
  end 
end
