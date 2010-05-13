authorization do  
  role :user do
    has_permission_on :roles,         :to => :read
    has_permission_on :user_sessions, :to => [:delete, :update]

    has_permission_on :users, :to => :read
    has_permission_on :users, :to => :update do  
      if_attribute :id => is { user.id }  
    end

    has_permission_on :tournament_reports, :to => :read
  end

  role :admin do  
    has_permission_on :roleuser_associations, :to => :manage
    has_permission_on :users,                 :to => :manage
    has_permission_on :roles,                 :to => :manage 
    has_permission_on :authorization_rules,   :to => :read
    has_permission_on :tournament_reports,    :to => :manage
  end  

  role :guest do  
    has_permission_on :users,                 :to => [:create, :update]
    has_permission_on :user_sessions,         :to => :create
    has_permission_on :roleuser_associations, :to => :create
  end  
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
