class AddTypeToAssociation < ActiveRecord::Migration
  def self.up
    add_column :associations, :type, :string
  end

  def self.down
    remove_column :associations, :type
  end
end
