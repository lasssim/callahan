class RoleuserAssociation < ActiveRecord::Base
  using_access_control

  belongs_to :user
  belongs_to :role
  validates_presence_of :user, :role
  validates_associated  :user, :role
end
