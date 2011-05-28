class CreateResearchProgresses < ActiveRecord::Migration
  def self.up
    create_table :research_progresses do |t|
      t.references :user, :null => false
      t.references :item, :null => false
      t.integer :progress, :limit => 8, :default => 0

      t.timestamps
    end

    add_index :research_progresses, :user_id
    add_index :research_progresses, :item_id
  end

  def self.down
    drop_table :research_progresses
  end
end
