class AddEquipmentToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :melee_weapon_id, :integer
    add_column :users, :ranged_weapon_id, :integer
    add_column :users, :armor_id, :integer
    add_column :users, :tool_id, :integer
  end

  def self.down
    remove_column :users, :tool_id
    remove_column :users, :armor_id
    remove_column :users, :ranged_weapon_id
    remove_column :users, :melee_weapon_id
  end
end
