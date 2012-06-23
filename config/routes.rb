Natarre::Application.routes.draw do

  get "mobile_api/register"

  get "mobile_api/login"

  get "mobile_api/fb_login"

  get "mobile_api/twitter_login"

  get "mobile_api/upload"

  post "stories/create" => "stories#create", :as => :stories
  get "stories" => "stories#index", :as => :stories_index  
  get "stories/new" => "stories#new", :as => :new_story
  get "story/:id" => "stories#show"

  get "register" => "users#register", :as => :register
  match "create" => "users#create", :as => :users

  match "mobile/api/register" => "mobile_api#register"
  match "/mobile/api/login/natarre" => "mobile_api#login"


  root :to => "home#index"


end
