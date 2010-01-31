authorization do  
  role :user do
    has_permission_on :roles, :to => [:index, :show]
    has_permission_on :users, :to => [:index, :show]
    has_permission_on :users, :to => [:edit, :update] do  
      if_attribute :user => is { user }  
    end 
  end

  role :admin do  
    has_permission_on [:users, :roles], :to => [:index, :show, :new, :create, :edit, :update, :destroy]  
  end  

  role :guest do  
    has_permission_on :users,         :to => [:new, :index]  
    has_permission_on :user_sessions, :to => [:new, :index]  
  end  
end

