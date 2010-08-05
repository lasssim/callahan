class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :activatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  has_many :ownedassociations, :class_name => "Association", :foreign_key => "owner_id"
  has_many :ownedteams,        :class_name => "Team",        :foreign_key => "owner_id"
  has_many :ownedevents,       :class_name => "Event",       :foreign_key => "owner_id"

  #has_and_belongs_to_many :associations
  has_and_belongs_to_many :playedteams, :class_name => "Team", :join_table => "teams_players", :foreign_key => "player_id"

  has_attached_file :avatar, :styles => { :medium => { :geometry => "300x300>", :format => :png, :effect => "mirror" }, 
                                          :thumb  => { :geometry => "120x120#", :format => :png, :effect => "mirror" },
                                          :tiny   => { :geometry => "40x40#",   :format => :png, :effect => "none"   } 
                                        },
                             :processors => [:thumbnail, :effect]
  
  has_private_messages

  acts_as_inquirable   :actions => [:friendship]
  acts_as_inquiry_item :actions => [:friendship]



  ###########################
  # Friends
  ###########################
  has_many :forward_friendships, :class_name => "Friendship", :foreign_key => "user_id"
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"  
  
  has_many :forward_friends, :through => :forward_friendships, :source => :friend
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user 

  attr_reader :friends

  def friends
    (forward_friends + inverse_friends).uniq
  end

  def is_my_friend?(_user)
    friends.include?(_user)
  end

  def accept_friend(_inquiry)
    friends << _inquiry.inquirer
  end

  def decline_friend(_inquiry)

  end

  attr_reader :name
  def name
    str = ""
    str += "#{forename} " unless forename.nil? or forename.empty?
    str += surname        unless surname.nil?  or surname.empty?
    str
  end

end
