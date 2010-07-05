ActionController::Routing::Routes.draw do |map|
  map.resources :users do |users|
    users.resources :messages, :collection => { :delete_selected => :post }
  end
  map.devise_for :users, :path_names => { :sign_in      => 'login', 
                                          :sign_out     => 'logout', 
                                          :registration => 'register'}


  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month
  map.calendar_root '/calendar', :controller => 'calendar'
  
  #map.calendar '/calendar', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month
  #map.connect  '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month

  map.resources :clubs
  map.resources :teams
  map.resources :associations
  map.resources :inquiries


  map.resources :editor
  map.resources :tournament_reports

  #map.resource :account, :controller => "users"
  map.root :controller => "users", :action => "index"
end
