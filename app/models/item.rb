class Item < ActiveRecord::Base
  validates_presence_of :name
  validates_inclusion_of :type, :in => %w{ Melee Ranged Armor Accessory }
end
