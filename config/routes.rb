Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root "users#index"
  resources :users, only: [:index] do
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :public_recipes, only: [:index]
    resources :recipes, only: [:index, :new, :show, :create, :destroy] do
      resources :recipe_foods, only: [:new, :edit, :create, :update, :destroy]
      resources :shopping_lists, only: [:index]
    end
  end
end
