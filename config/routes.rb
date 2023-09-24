Rails.application.routes.draw do


  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
}

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

  root to: "public/homes#top"
  get "/home/about" =>"public/homes#about" ,as: "about"

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  scope module: :public  do
    resources :items, only: [:show, :index]
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:show, :edit, :update, :quit, :leave]
    resources :cart_items, only: [:index, :update, :destroy, :all_destroy, :create]
    resources :orders, only: [:new, :confirm, :thanks, :create, :index, :show]
    resources :customers, only: [:show, :edit, :update, :quit, :leave]
    
  end



end