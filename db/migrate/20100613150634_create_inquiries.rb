class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.references :inquirer
      t.string     :inquirer_type

      t.references :inquiree
      t.string     :inquiree_type
      
      t.references :inquiry_item
      t.string     :inquiry_item_type

      t.string :message
      t.string :action
      t.string :state
     t.timestamps
    end
  end

  def self.down
    drop_table :inquiries
  end
end
