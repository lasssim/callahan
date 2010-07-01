class Team < ActiveRecord::Base
  belongs_to :association
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

  #has_and_belongs_to_many :players, :class_name => "User", :join_table => "teams_players", :association_foreign_key => "player_id"
end
