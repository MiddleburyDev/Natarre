Natarre::Application.routes.draw do
  get "home/index"

  get "story/:id" => "stories#show"

  root :to => "home#index"


end
