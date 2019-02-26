Rails.application.routes.draw do
  root to: 'recipes#index' 
  resources :recipes
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
