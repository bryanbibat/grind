class ChangeItemTypeName < ActiveRecord::Migration
  def self.up
    remove_index :items, :type
    rename_column :items, :type, :item_type
    add_index :items, :item_type
  end

  def self.down
    remove_index :items, :item_type
    rename_column :items, :item_type, :type
    add_index :items, :type
  end
end
