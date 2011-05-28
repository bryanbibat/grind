class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.string :username, :null => false
      t.string :display_name
      t.integer :xp, :limit => 8, :default => 0
      t.integer :health, :limit => 8, :default => 0
      t.integer :energy, :limit => 8, :default => 0
      t.integer :credits, :limit => 8, :default => 0
      t.integer :melee, :limit => 8, :default => 5
      t.integer :ranged, :limit => 8, :default => 5
      t.integer :defense, :limit => 8, :default => 5
      t.integer :agility, :limit => 8, :default => 5
      t.integer :cunning, :limit => 8, :default => 5
      t.integer :available_points, :default => 0
      t.boolean :admin, :default => false

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :username,             :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
