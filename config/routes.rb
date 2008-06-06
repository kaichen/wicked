ActionController::Routing::Routes.draw do |map|

  # App根路径
  map.root :controller => 'site', :action => 'index'
  map.resource :session
  map.resources :users
  map.resources :forums, :has_many => :topics
  map.resources :topics, :has_many => :replies, 
                         :member =>{ :create => :post }

  # 注册，登录，登出
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.connect 'site/:action', :controller => 'site'
  map.about 'about/', :controller => 'site', :action => 'index'
  map.teams 'teams/', :controller => 'site', :action => 'index'

end
