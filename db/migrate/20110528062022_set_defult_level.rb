class SetDefultLevel < ActiveRecord::Migration
  def self.up
    change_column :users, :level, :integer, :limit => 8, :default => 1
  end

  def self.down
    change_column :users, :level, :integer, :limit => 8
  end
end
