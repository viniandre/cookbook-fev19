Rails.application.routes.draw do
  
  devise_for :users
  root to: 'recipes#index' 
  get 'my_recipes', to: 'recipes#my_recipes'
  resources :lists
  resources :recipes do
    get 'search', on: :collection
    member do
      get 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
      post 'add_list'
    end
  end
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
