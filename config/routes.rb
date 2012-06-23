Natarre::Application.routes.draw do

  get "stories/new"
  post "stories/create"
  get "stories" => "stories#index", :as => :stories_index
  post "stories/create" => "stories#create", :as => :stories
  get "stories/new" => "stories#new", :as => :new_story
  get "story/:id" => "stories#show"

  get "register" => "users#register", :as => :register
  match "create" => "users#create", :as => :users



  root :to => "home#index"


end
