Natarre::Application.routes.draw do

  get "stories/new"
  post "stories/create"

  get "prompts/new" => "prompts#new", :as => :new_prompt
  post "prompts/create" => "prompts#create", :as => :create_prompt
  get "prompt" => "stories#prompt", :as => :prompt
  get "prompt/(:id)" => "stories#prompt", :as => :prompt
  get "prompts" => "stories#prompts", :as => :prompts
  get "popular" => "stories#popular", :as => :popular


  get "stories" => "stories#index", :as => :stories_index
  post "stories/create" => "stories#create", :as => :stories
  get "stories" => "stories#index", :as => :stories_index  
  get "stories/new" => "stories#new", :as => :new_story
  get "stories/new/:id" => "stories#new", :as => :new_story_prompt
  get "story/:id" => "stories#show", :as => :story
  match "comments/new" => "stories#add_comment", :as => :comments
  match "votes/new/(:id)" => "stories#add_vote", :as => :votes
  match "list/new/(:id)" => "stories#add_list", :as => :lists

  match "user/edit" => "users#edit", :as => :profile
  match "user/update" => "users#update", :as => :update_profile


  match "session/create" => "sessions#create"
  match "session/destroy" => "sessions#destroy", :as => :logout

  match "login" => "users#login", :as => :login
  match "register" => "users#register", :as => :register
  match "create" => "users#create", :as => :users

  match "mobile/api/register/natarre" => "mobile_api#register"
  match "mobile/api/login/natarre" => "mobile_api#login"
  match "mobile/api/story/upload" => "mobile_api#upload"
  match "mobile/api/story/comment" => "mobile_api#comment"
  match "mobile/api/stories/one" => "mobile_api#story"
  match "mobile/api/prompts/thisweek" =>"mobile_api#this_week"
  match "mobile/api/prompts/all" => "mobile_api#all_prompts"
  match "mobile/api/stories/forprompt" => "mobile_api#forprompt"
  match "mobile/api/stories/popular" => "mobile_api#popular"
  match "mobile/api/stories/readinglist" => "mobile_api#readinglist"
  match "/mobile/api/stories/favorites" => "mobile_api#favorites"



  match "credits" => "home#credits", :as => :credits
  root :to => "stories#prompt"


end
