Rails.application.routes.draw do

   devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root "users#index"
  resources :users, only: [:index, :show] do
    resources :foods, only: [:index, :show, :new, :create, :destroy]
    resources :recipes, only: [:index, :new, :show, :create, :destroy] do
      resources :recipe_foods, only: [:new, :edit, :create, :update, :destroy]
      resources :general_shopping_list, only: [:index]
    end
  end
end
