class AddCompletedToResearchProgress < ActiveRecord::Migration
  def self.up
    add_column :research_progresses, :completed, :boolean, :default => false
  end

  def self.down
    remove_column :research_progresses, :completed
  end
end
