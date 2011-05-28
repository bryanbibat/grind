class Item < ActiveRecord::Base
  def self.types 
    %w{ Melee Ranged Armor Accessory }
  end
  validates_presence_of :name
  validates_inclusion_of :item_type, :in => self.types

  has_many :owned_items
  has_many :research_progresses

end
