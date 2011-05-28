class Loot < ActiveRecord::Base
  belongs_to :mission
  belongs_to :item
end
