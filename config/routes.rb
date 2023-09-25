Rails.application.routes.draw do


  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end
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
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: :public  do
    resources :items, only: [:show, :index]
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:show, :edit, :update, :quit, :leave]
    resources :cart_items, only: [:index, :update, :destroy, :all_destroy, :create]
    resources :orders, only: [:new, :confirm, :thanks, :create, :index, :show]

    get "customer/edit" => "/customers#edit"
    patch "customers/update" => "customers#update"

    resources :customers, only: [:show] do
      collection  do
        get :"quit"
        patch :"leave"
      end
  end

  end



end