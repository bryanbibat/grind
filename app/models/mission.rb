class Mission < ActiveRecord::Base
  validates_presence_of :name, :req_level, :req_energy, :xp_min, :xp_max

  def self.available_missions(user)
    where("req_level <= ?", user.level)
  end

  def can_be_performed_by_user(user)
    @mission_errors = []
    @mission_errors << "Your level is not high enough" if req_level > user.level
    @mission_errors << "You cannot take missions if you have no health" if user.health <= 0
    @mission_errors << "You do not have enough energy" if req_energy > user.energy
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

  def attempt(user)
    return false unless can_be_performed_by_user user
    user.energy -= req_energy
    if try_mission(user)
      user.apply_rewards(self)
      @mission_messages = ["Mission successful",
        "You gained #{ @credits_reward } credits and #{ @xp_reward } XP"]
      user.save
      return true
    else
      user.subtract_health(damage)
      @mission_errors = ["Mission failed",
        "You lost #{ damage } HP"]
      user.save
      return false
    end
  end

  def credits_reward
    @credits_reward ||= credits_min + rand(credits_max - credits_min + 1)
  end
  
  def xp_reward
    @xp_reward ||= xp_min + rand(xp_max - xp_min + 1)
  end

  private

  def try_mission(user)
    rand(total_mission_points) + 1 <= user_points(user)
  end

  def total_mission_points
    points = 0
    points += max_melee - min_melee + 1 if check_melee?
    points += max_ranged - min_ranged + 1 if check_ranged?
    points += max_defense - min_defense + 1 if check_defense?
    points += max_agility - min_agility + 1 if check_agility?
    points += max_cunning - min_cunning + 1 if check_cunning?
    points
  end

  def user_points(user)
    user_points = 0
    if check_melee?
      user_melee = (user.effective_melee >= max_melee) ? max_melee : user.effective_melee
      user_points += user_melee - min_melee + 1
    end
    if check_ranged?
      user_ranged = (user.effective_ranged >= max_ranged) ? max_ranged : user.effective_ranged
      user_points += user_ranged - min_ranged + 1
    end
    if check_defense?
      user_defense = (user.effective_defense >= max_defense) ? max_defense : user.effective_defense
      user_points += user_defense - min_defense + 1
    end
    if check_agility?
      user_agility = (user.effective_agility >= max_agility) ? max_agility : user.effective_agility
      user_points += user_agility - min_agility + 1
    end
    if check_cunning?
      user_cunning = (user.effective_cunning >= max_cunning) ? max_cunning : user.effective_cunning
      user_points += user_cunning - min_cunning + 1
    end
    user_points
  end
end
