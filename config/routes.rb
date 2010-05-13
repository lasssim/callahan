ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :roles
  map.resources :password_resets
  map.resources :editor
  map.resources :tournament_reports
  
  map.resource :user_session
  
  #map.resource :account, :controller => "users"
  map.root :controller => "user_sessions", :action => "new"
end
