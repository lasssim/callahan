class CreateAssociations < ActiveRecord::Migration
  def self.up
    create_table :associations do |t|
      t.references :parent
      t.references :owner
      t.integer :lft
      t.integer :rgt
      t.string :name
      t.string :abbrevation
      t.string :url
      t.string :realm

      t.timestamps
    end

    add_index :associations, :name
    add_index :associations, :abbrevation

    create_table :associations_users do |t|
      t.references :association
      t.references :user
    end
  end

  def self.down
    drop_table :associations
    drop_table :associations_users
  end
end
