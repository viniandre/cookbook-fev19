Rails.application.routes.draw do
  root to: 'recipes#index' 
  resources :recipes do 
    get 'search', on: :collection
  end
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
