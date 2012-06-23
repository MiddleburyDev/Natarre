Natarre::Application.routes.draw do

<<<<<<< HEAD
  get "mobile_api/register"

  get "mobile_api/login"

  get "mobile_api/fb_login"

  get "mobile_api/twitter_login"

  get "mobile_api/upload"

=======
  get "stories/new"
  post "stories/create"

  get "prompts" => "stories#prompts", :as => :prompts
  get "popular" => "stories#popular", :as => :popular
  get "stories" => "stories#index", :as => :stories_index
>>>>>>> 86dc18f9882fb411ceab733ee76a428cc16d0faa
  post "stories/create" => "stories#create", :as => :stories
  get "stories" => "stories#index", :as => :stories_index  
  get "stories/new" => "stories#new", :as => :new_story
  get "story/:id" => "stories#show", :as => :story
  match "comments/new" => "stories#add_comment", :as => :comments

  match "session/create" => "sessions#create"
  match "session/destroy" => "sessions#destroy"

  match "login" => "users#login", :as => :login
  match "register" => "users#register", :as => :register
  match "create" => "users#create", :as => :users

  match "mobile/api/register" => "mobile_api#register"
  match "/mobile/api/login/natarre" => "mobile_api#login"


  root :to => "stories#prompts"


end
