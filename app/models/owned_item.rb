class OwnedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  before_validation :set_default_rarity

  def self.generate_new_loot(loot)
    item = OwnedItem.new(:item_id => loot.item_id)
    roll_for_rarity = rand(1000)
    min_bonus = 0
    max_bonus = 0
    if roll_for_rarity <= loot.rare_rate_1000
      item.rarity = "Rare"
      max_bonus = loot.uncommon_bonus
    elsif roll_for_rarity <= loot.uncommon_rate_1000
      item.rarity = "Uncommon"
      min_bonus = loot.uncommon_bonus
      max_bonus = loot.rare_bonus
    end
    unless item.rarity.nil?
      item.roll_bonuses(min_bonus, max_bonus)
    end
    item
  end

  def display_name
    "a#{rarity == "Uncommon" ? "n" : ""} #{rarity == "Common" ? "" : rarity} #{item.name}"
  end

  def effective_melee
    item.melee + melee
  end

  def effective_ranged
    item.ranged + ranged
  end

  def effective_defense
    item.defense + defense
  end

  def effective_agility
    item.agility + agility
  end

  def effective_cunning
    item.cunning + cunning
  end

  def effective_price
    item.price + price_bonus
  end

  def roll_bonuses(min_bonus, max_bonus)
    if melee > 0 
      self.melee = (min_bonus + rand(max_bonus - min_bonus)) / 100
    end
    if ranged > 0 
      self.ranged = (min_bonus + rand(max_bonus - min_bonus))/ 100
    end
    if defense > 0 
      self.defense = (min_bonus + rand(max_bonus - min_bonus))/ 100
    end
    if agility > 0 
      self.agility = (min_bonus + rand(max_bonus - min_bonus))/ 100
    end
    if cunning > 0 
      self.cunning = (min_bonus + rand(max_bonus - min_bonus))/ 100
    end
    if price_bonus > 0 
      self.price_bonus = (min_bonus + rand(max_bonus - min_bonus))/ 100
    end
  end

  private 

  def set_default_rarity
    self.rarity ||= "Common"
  end

end
