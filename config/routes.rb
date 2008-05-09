ActionController::Routing::Routes.draw do |map|
 
  map.root :controller => 'site', :action => 'index'
  map.about 'about/', :controller => 'site', :action => 'index'
  map.teams 'teams/', :controller => 'site', :action => 'index'
  map.resources :forums, :has_many => :topics
  map.resources :topics, :has_many => :replies, :member=>{ :create=>:post }

end
