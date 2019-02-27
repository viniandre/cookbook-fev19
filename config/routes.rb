Rails.application.routes.draw do
  
  devise_for :users
  root to: 'recipes#index' 

  resources :recipes do 
    get 'search', on: :collection
    get 'favorite', on: :member
    delete 'favorite', to: 'recipes#unfavorite', on: :member
  end
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
end
