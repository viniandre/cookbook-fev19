Rails.application.routes.draw do
  root to: 'recipes#index' 
  resources :recipes , only: [:new, :edit, :update, :create, :show, :index]
end
