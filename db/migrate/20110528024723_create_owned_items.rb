class CreateOwnedItems < ActiveRecord::Migration
  def self.up
    create_table :owned_items do |t|
      t.references :user, :null => false
      t.references :item, :null => false
      t.string :nickname
      t.integer :melee, :limit => 8, :default => 0
      t.integer :ranged, :limit => 8, :default => 0
      t.integer :defense, :limit => 8, :default => 0
      t.integer :agility, :limit => 8, :default => 0
      t.integer :cunning, :limit => 8, :default => 0
      t.integer :price_bonus, :limit => 8, :default => 0
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.string :rarity

      t.timestamps
    end

    add_index :owned_items, :user_id
    add_index :owned_items, :item_id
  end

  def self.down
    drop_table :owned_items
  end
end
