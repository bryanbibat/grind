class DefaultUserValues < ActiveRecord::Migration
  def self.up
    change_column :users, :health, :integer, :limit => 8, :default => 100
    change_column :users, :energy, :integer, :limit => 8, :default => 100
  end

  def self.down
    change_column :users, :health, :integer, :limit => 8
    change_column :users, :energy, :integer, :limit => 8
  end
end
