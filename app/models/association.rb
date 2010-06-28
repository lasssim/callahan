class Association < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many   :teams
  has_many   :invitations, :as => :inviteable


  #has_and_belongs_to_many :users
  
  acts_as_nested_set
  
  acts_as_mappable 
  before_validation_on_create :geocode_realm
  validate :validate_geocode

  acts_as_inquiry_item :actions => [:ownership]

  attr_reader :coords

  def coords
    [self.lat, self.lng]
  end
  

  private
  def geocode_realm
    return if realm == "International"
    geo=Geokit::Geocoders::MultiGeocoder.geocode(realm)
    #errors.add(:realm, "Could not Geocode address") if !geo.success
    if geo.success
      self.lat, self.lng = geo.lat,geo.lng 
#      set_country_code
    end
  end
 
  def validate_geocode
    return if realm == "International"
    geo=Geokit::Geocoders::MultiGeocoder.geocode(realm)
    if geo.success
      self.lat, self.lng = geo.lat,geo.lng 
#     set_country_code
    else
#      errors.add(:realm, "Could not Geocode realm.")
    end
  end

  def accept_ownership(_inquiry)
    self.owner = _inquiry.inquirer
    save
  end


end
#  def set_country_code
#    cc = Geokit::Geocoders::GoogleGeocoder.do_reverse_geocode(self.coords).country_code
#    if cc
#      self.country_code = cc.downcase
#    else
#      self.country_code = ""
#    end
#  end
#
#end
#
#class RootAssociation < Association
#  attr_reader :realm
#  private
#    def realm
#      "International"
#    end
#end

