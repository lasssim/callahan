class AddAdditionalFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :number,      :string
    add_column :users, :birthday,    :date
    add_column :users, :female,      :boolean
    add_column :users, :veggie,      :boolean
    add_column :users, :plays_since, :date
    add_column :users, :skype,       :string
    add_column :users, :icq,         :integer
    add_column :users, :facebook,    :string
    add_column :users, :twitter,     :string
    add_column :users, :myspace,     :string
    add_column :users, :studivz,     :string
    add_column :users, :forename,    :string
    add_column :users, :surname,     :string
    add_column :users, :homepage,    :string
    add_column :users, :hometown,    :string
  end

  def self.down
    remove_column :users, :hometown
    remove_column :users, :homepage
    remove_column :users, :surname
    remove_column :users, :forename
    remove_column :users, :studivz
    remove_column :users, :myspace
    remove_column :users, :twitter
    remove_column :users, :facebook
    remove_column :users, :icq
    remove_column :users, :skype
    remove_column :users, :plays_since
    remove_column :users, :veggie
    remove_column :users, :female
    remove_column :users, :birthday
    remove_column :users, :number
  end
end
