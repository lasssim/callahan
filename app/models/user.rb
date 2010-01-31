class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :roles
  
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
