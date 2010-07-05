class Event < ActiveRecord::Base
  has_event_calendar
  
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  
end