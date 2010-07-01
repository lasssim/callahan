class AddFlickrFieldToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :flickr, :string
  end

  def self.down
    remove_column :users, :flickr
  end
end
