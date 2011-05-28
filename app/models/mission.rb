class Mission < ActiveRecord::Base
  validates_presence_of :name, :req_level, :req_energy, :xp_min, :xp_max

  def self.available_missions(user)
    where("req_level <= ?", user.level)
  end

  def can_be_performed_by_user(user)
    @mission_errors << "Your level is not high enough" if req_level > user.level
    if check_melee? and min_melee > user.effective_melee
      @mission_errors << "Your Melee skill is not high enough"
    end
    if check_ranged? and min_ranged > user.effective_ranged
      @mission_errors << "Your Ranged skill is not high enough"
    end
    if check_defense? and min_defense > user.effective_defense
      @mission_errors << "Your Defense skill is not high enough"
    end
    if check_agility? and min_agility > user.effective_agility
      @mission_errors << "Your Agility skill is not high enough"
    end
    if check_cunning? and min_cunning > user.effective_cunning
      @mission_errors << "Your Cunning skill is not high enough"
    end
    @mission_errors.empty?
  end

  def mission_errors
    @mission_errors
  end

  def mission_messages
    @mission_messages
  end
end
