class Role < ActiveRecord::Base
 # has_and_belongs_to_many :users
  has_many :roleuser_associations
  has_many :users, :through => :roleuser_associations

  using_access_control
end
