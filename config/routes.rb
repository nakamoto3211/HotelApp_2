Rails.application.routes.draw do
  get 'reservations/index'
  root to: "users#home"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :users, :only => [:show, :edit, :update]

  resources :rooms, :only => [:index, :new, :create, :show] do
    collection do
      get 'search'
    end
  end

  resources :reservations, :only => [:index, :create] do
    collection do
      post :confirm
    end
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
