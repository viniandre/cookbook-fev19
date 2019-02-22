Rails.application.routes.draw do
  root to: 'recipes#index' 
  resources :recipes , only: [:new, :edit, :update, :create, :show, :index]
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
