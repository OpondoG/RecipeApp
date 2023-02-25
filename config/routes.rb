Rails.application.routes.draw do
 devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root "users#index"
  resources :users do
    resources :recipes
  end
  resources :users, only: [:index]
  resources :recipes, only: [:index, :new, :show, :create, :destroy] do
  resources :foods, only: [:index, :new, :show, :create, :destroy]
    resources :recipe_foods, only: [:new, :edit, :create, :update, :destroy]
  end

  resources :shopping_lists, only: [:index]
  resources :public_recipes, only: [:index]
  resources :foods, only: [:index, :new, :show, :create, :destroy]
end


