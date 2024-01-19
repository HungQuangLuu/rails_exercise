Rails.application.routes.draw do
  resources :tasks # create router for CRUD on tasks /tasks

  get "up" => "rails/health#show", as: :rails_health_check
  
end
