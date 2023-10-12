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
    get "admin" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

  scope module: :public  do
    resources :items, only: [:show, :index]
    delete "cart_items/all_destroy" => "cart_items#all_destroy"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    post "orders/confirm" => "orders#confirm"
    get "orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]

    get "customers/my_page" => "customers#show"
    get "customers/informetion/edit" => "customers#edit"
    patch "customers/informetion" => "customers#update"
    get "customers/quit" => "customers#quit"
    patch "customers/leave" => "customers#leave"
  end

  end