ActionController::Routing::Routes.draw do |map|
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.now.year, :month => Time.now.month

  map.resources :clubs
  map.resources :teams
  map.resources :associations
  map.resources :inquiries

  map.resources :users
  map.resources :users do |users|
    users.resources :messages, :collection => { :delete_selected => :post }
  end


  map.resources :roles
  map.resources :password_resets
  map.resources :editor
  map.resources :tournament_reports
  
  map.resource :user_session
 
  

  #map.resource :account, :controller => "users"
  map.root :controller => "user_sessions", :action => "new"
end
