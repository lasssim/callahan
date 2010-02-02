class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :roles

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "40x40>" }

#	using_access_control


  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def role_symbols  
    roles.map do |role|  
      role.name.underscore.to_sym  
    end  
  end  

end
