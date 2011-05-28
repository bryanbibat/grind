class CreateMissions < ActiveRecord::Migration
  def self.up
    create_table :missions do |t|
      t.string :name, :null => false
      t.string :subtitle
      t.text :description
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at

      t.integer :req_level, :limit => 8
      t.integer :req_energy, :limit => 8
      t.integer :xp_min, :limit => 8
      t.integer :xp_max, :limit => 8
      t.integer :damage, :limit => 8
      t.boolean :check_melee
      t.integer :min_melee, :limit => 8
      t.integer :max_melee, :limit => 8
      t.boolean :check_ranged
      t.integer :min_ranged, :limit => 8
      t.integer :max_ranged, :limit => 8
      t.boolean :check_defense
      t.integer :min_defense, :limit => 8
      t.integer :max_defense, :limit => 8
      t.boolean :check_agility
      t.integer :min_agility, :limit => 8
      t.integer :max_agility, :limit => 8
      t.boolean :check_cunning
      t.integer :min_cunning, :limit => 8
      t.integer :max_cunning, :limit => 8

      t.timestamps
    end

    add_index :missions, :name, :unique => true
  end

  def self.down
    drop_table :missions
  end
end
