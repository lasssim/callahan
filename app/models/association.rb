class Association < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many   :teams
  
  #has_and_belongs_to_many :users
  
  acts_as_nested_set
  
  acts_as_mappable 
  before_validation_on_create :geocode_realm
  validate :validate_geocode

  attr_reader :coords

  def coords
    [self.lat, self.lng]
  end
  

  private
  def geocode_realm
    geo=Geokit::Geocoders::MultiGeocoder.geocode(realm)
    #errors.add(:realm, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
 
  def validate_geocode
    geo=Geokit::Geocoders::MultiGeocoder.geocode(realm)
    errors.add(:realm, "Could not Geocode realm.") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
 

end
