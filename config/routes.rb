Natarre::Application.routes.draw do


  #get "story/:id" => "stories#show"
  resources :stories
  get "register" => "users#register", :as => :register
  match "create" => "users#create", :as => :users
  root :to => "home#index"


end
