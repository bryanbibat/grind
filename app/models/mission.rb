class Mission < ActiveRecord::Base
  validates_presence_of :name, :req_level, :req_energy, :xp_min, :xp_max
end
