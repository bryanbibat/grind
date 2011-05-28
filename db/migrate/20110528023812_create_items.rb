class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :type
      t.text :description
      t.string :picture_file_name
      t.string :picture_content_type
      t.string :picture_file_size
      t.datetime :picture_updated_at
      t.integer :melee, :limit => 8, :default => 0
      t.integer :ranged, :limit => 8, :default => 0
      t.integer :defense, :limit => 8, :default => 0
      t.integer :agility, :limit => 8, :default => 0
      t.integer :cunning, :limit => 8, :default => 0
      t.integer :req_research, :limit => 8, :default => 0
      t.integer :price, :limit => 8, :default => 0

      t.timestamps
    end

    add_index :items, :name, :unique => true
    add_index :items, :type, :unique => true
  end

  def self.down
    drop_table :items
  end
end
