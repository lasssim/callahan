class User < ActiveRecord::Base
  acts_as_authentic
  using_access_control

  has_many :roleuser_associations
  has_many :roles,                :through => :roleuser_associations

  has_many :ownedassociations, :class_name => "Association", :foreign_key => "owner_id"
  has_many :ownedteams,        :class_name => "Team",        :foreign_key => "owner_id"

  #has_and_belongs_to_many :associations
  has_and_belongs_to_many :playedteams, :class_name => "Team", :join_table => "teams_players", :foreign_key => "player_id"

  has_attached_file :avatar, :styles => { :medium => { :geometry => "300x300>", :format => :png, :effect => "mirror" }, 
                                          :thumb  => { :geometry => "120x120#", :format => :png, :effect => "mirror" },
                                          :tiny   => { :geometry => "40x40#",   :format => :png, :effect => "none"   } 
                                        },
                             :processors => [:thumbnail, :effect]
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def role_symbols  
    roles.map do |role|  
      role.name.underscore.to_sym  
    end  
  end  


  attr_reader :name
  def name
    str = ""
    str += "#{forename} " unless forename.nil? or forename.empty?
    str += surname        unless surname.nil?  or surname.empty?
    str = login           if     str.empty?
    str
  end

end
