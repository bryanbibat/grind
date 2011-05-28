class CreateLoots < ActiveRecord::Migration
  def self.up
    create_table :loots do |t|
      t.references :mission, :null => false
      t.references :item, :null => false
      t.integer :drop_rate_10000, :default => 2500
      t.integer :uncommon_rate_1000, :default => 200
      t.integer :rare_rate_1000, :default => 10
      t.integer :uncommon_bonus
      t.integer :rare_bonus

      t.timestamps
    end

    add_index :loots, :mission_id
    add_index :loots, :item_id
  end

  def self.down
    drop_table :loots
  end
end
