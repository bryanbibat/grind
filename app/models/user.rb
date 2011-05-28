class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :display_name, :melee_weapon_id,:ranged_weapon_id, :armor_id, :tool_id

  validates_numericality_of :available_points, :only_integer => true, :greater_than_or_equal_to => 0

  has_many :owned_items
  has_many :items, :through => :owned_items, :uniq => true
  has_many :research_progresses
  belongs_to :melee_weapon, :class_name => "OwnedItem"
  belongs_to :ranged_weapon, :class_name => "OwnedItem"
  belongs_to :armor, :class_name => "OwnedItem"
  belongs_to :tool, :class_name => "OwnedItem"

  def self.level_xp_req
    #fibonacci sequence
    [10, 20, 30, 50, 80, 
      130, 210, 340, 550, 890, 
      1440, 2330, 3770, 6100, 9870, 
      15970, 25840, 41810, 67650, 109460, 
      177110, 286570, 463680, 750250, 1213930, 
      1964180, 3178110, 5142290, 8320400, 13462690, 
      21783090, 35245780, 57028870,  92274650, 149303520, 
      241578170, 390881690, 632459860, 1023341550, 1655801410, 
      2679142960, 4334944370, 7014087330, 11349031700, 18363119030, 
      29712150730, 48075269760, 77787420490, 125862690250, 203650110740, 
      329512800990, 533162911730, 862675712720, 1395838624450, 2258514337170, 
      3654352961620, 5912867298790, 9567220260410, 15480087559200, 25047307819610]
  end

  def effective_melee
    melee + (melee_weapon.nil? ? 0 : melee_weapon.effective_melee) +
      (ranged_weapon.nil? ? 0 : ranged_weapon.effective_melee) +
      (armor.nil? ? 0 : armor.effective_melee) +
      (tool.nil? ? 0 : tool.effective_melee)
  end

  def effective_ranged
    ranged + (melee_weapon.nil? ? 0 : melee_weapon.effective_ranged) +
      (ranged_weapon.nil? ? 0 : ranged_weapon.effective_ranged) +
      (armor.nil? ? 0 : armor.effective_ranged) +
      (tool.nil? ? 0 : tool.effective_ranged)
  end

  def effective_defense
    defense + (melee_weapon.nil? ? 0 : melee_weapon.effective_defense) +
      (ranged_weapon.nil? ? 0 : ranged_weapon.effective_defense) +
      (armor.nil? ? 0 : armor.effective_defense) +
      (tool.nil? ? 0 : tool.effective_defense)
  end

  def effective_agility
    agility + (melee_weapon.nil? ? 0 : melee_weapon.effective_agility) +
      (ranged_weapon.nil? ? 0 : ranged_weapon.effective_agility) +
      (armor.nil? ? 0 : armor.effective_agility) +
      (tool.nil? ? 0 : tool.effective_agility)
  end
  
  def effective_cunning
    cunning + (melee_weapon.nil? ? 0 : melee_weapon.effective_cunning) +
      (ranged_weapon.nil? ? 0 : ranged_weapon.effective_cunning) +
      (armor.nil? ? 0 : armor.effective_cunning) +
      (tool.nil? ? 0 : tool.effective_cunning)
  end

  def apply_rewards(mission)
    self.credits += mission.credits_reward
    add_xp_and_check_level_up mission.xp_reward
    if mission.loot_reward.class == OwnedItem
      self.owned_items << mission.loot_reward
      item_id = mission.loot_reward.item_id
      unless research_progresses.map{ |x| x.item_id }.include? item_id
        mission.loot_reward.item.reload
        research_progresses.create(:item_id => item_id)
      end
    end
  end

  def xp_for_next_level
    User.level_xp_req[level - 1]
  end

  def subtract_health(damage)
    self.health -= damage
  end

  def upgrade_melee
    return if available_points <= 0
    self.available_points -= 1
    self.melee += 1
    save
  end

  def upgrade_ranged
    return if available_points <= 0
    self.available_points -= 1
    self.ranged += 1
    save
  end

  def upgrade_defense
    return if available_points <= 0
    self.available_points -= 1
    self.defense += 1
    save
  end

  def upgrade_agility
    return if available_points <= 0
    self.available_points -= 1
    self.agility += 1
    save
  end

  def upgrade_cunning
    return if available_points <= 0
    self.available_points -= 1
    self.cunning += 1
    save
  end

  def researched_ids(type)
    research_progresses.where(:completed => true).select { |x| x.item.item_type == type }.map { |x| x.item_id }
  end

  def researched_items(type)
    owned_items.where(:item_id => researched_ids(type))
  end

  private

  def add_xp_and_check_level_up(xp_bonus)
    self.xp += xp_bonus
    while xp >= xp_for_next_level
      level_up
    end
  end

  def level_up
    self.level += 1
    self.available_points += points_for_this_level
    self.energy += energy_for_this_level 
  end

  def points_for_this_level
    level ** 2
  end

  def energy_for_this_level
    points_for_this_level * 5
  end

end
