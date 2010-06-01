class AddLatLngToAssociation < ActiveRecord::Migration
  def self.up
    add_column :associations, :lat, :float
    add_column :associations, :lng, :float
  end

  def self.down
    remove_column :associations, :lng
    remove_column :associations, :lat
  end
end
