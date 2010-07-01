class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships, :id => false do |t|
      t.references :user
      t.references :friend
      t.timestamps
    end
    
    add_index :friendships, [:user_id, :friend_id]
  end

  def self.down
    drop_table :friendships
  end
end
