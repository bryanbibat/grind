class AddMoneyRewardToMission < ActiveRecord::Migration
  def self.up
    add_column :missions, :credits_min, :integer, :limit => 8, :default => 0
    add_column :missions, :credits_max, :integer, :limit => 8, :default => 0
  end

  def self.down
    remove_column :missions, :credits_max
    remove_column :missions, :credits_min
  end
end
