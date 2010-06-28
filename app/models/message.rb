class Message < ActiveRecord::Base

  is_private_message
  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
#attr_accessor :to
  
  def recipient_login
    puts "getter"
    recipient.login if recipient
  end

  def recipient_login=(login)
    puts "setter"
    puts  User.find_by_login(login).name
    self.recipient = User.find_by_login(login)
  end
end
