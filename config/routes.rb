Natarre::Application.routes.draw do

  get "stories/new"
  post "stories/create"

  get "prompts/new" => "prompts#new", :as => :new_prompt
  post "prompts/create" => "prompts#create", :as => :create_prompt
  get "prompts" => "stories#prompts", :as => :prompts
  get "popular" => "stories#popular", :as => :popular
  get "stories" => "stories#index", :as => :stories_index
  post "stories/create" => "stories#create", :as => :stories
  get "stories" => "stories#index", :as => :stories_index  
  get "stories/new" => "stories#new", :as => :new_story
  get "stories/new/:id" => "stories#new", :as => :new_story_prompt
  get "story/:id" => "stories#show", :as => :story
  match "comments/new" => "stories#add_comment", :as => :comments

  match "session/create" => "sessions#create"
  match "session/destroy" => "sessions#destroy"

  match "login" => "users#login", :as => :login
  match "register" => "users#register", :as => :register
  match "create" => "users#create", :as => :users

  match "mobile/api/register/natarre" => "mobile_api#register"
  match "mobile/api/login/natarre" => "mobile_api#login"
  match "mobile/api/story/upload" => "mobile_api#upload"
  match "mobile/api/story/comment" => "mobile_api#comment"
  match "mobile/api/stories/one" => "mobile_api#story"
  root :to => "stories#prompts"


end
