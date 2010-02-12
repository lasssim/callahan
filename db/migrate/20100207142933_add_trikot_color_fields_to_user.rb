class AddTrikotColorFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :trikot_color, :string
  end

  def self.down
    remove_column :users, :trikot_color
  end
end
