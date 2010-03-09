class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end

    create_table :roleuser_associations, :id => false do |t|
      t.references :role, :user
    end

  end

  def self.down
    drop_table :roles
    drop_table :roleuser_associations
  end
end
