Rails.application.routes.draw do
  namespace :public do
    get 'searchs/search'
  end

  namespace :public do
    get 'user/edit'
    get 'user/show'
    put 'user/edit'
    put 'user/show'
    post 'user/update'
    get 'user/update'
    patch 'user/update'
  end

  namespace :public do
    post 'contacts/new'
    get 'contacts/new'
    post 'contacts/confirm'
    post 'contacts/back'
    get 'contacts/done'
    post 'contacts/create'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
  end

  namespace :public do
    post 'chats/create'
  end

  # namespace :admin do
  # patch 'users/update'
  # get 'users/show'
  # end

  root to: 'public/products#top'
  get 'products/about'
  post 'orders/complete'

  namespace :public do
    resources 'rooms', only: [:index, :show, :create]
    resources 'products', only: [:index, :show, :top, :create] do
      resources :favorites, only: [:create]
      delete 'favorites' => 'favorites#destroy'
      collection do
        get 'about'
        resources 'comments', only: [:create, :destroy]
      end
    end

    resources 'payment_cards', only: [:new, :create, :index, :destroy]
    resources 'orders', only: [:index, :show, :new, :create] do
      collection do
        post 'check'
        get  'complete'
      end
    end

    resources 'cart_items', only: [:index, :update, :create, :destroy] do
      collection do
        delete '/' => 'cart_items#destroy_all'
      end
    end
  end

  namespace :admin do
    get 'orders' => 'orders#top', as: :root
    resources 'rooms', only: [:index, :show, :create]
    resource 'chats', only: [:create]
    resources 'orders', only: [:show, :update] do
      member do
        get :costomer_top
        get :top
      end
    end
    resources 'ordered_products', only: [:update]
    resources 'users', only: [:index, :show, :edit, :update]
    resources 'products', only: [:create, :new, :index, :edit, :update, :show]
    resources 'genres', only: [:create, :new, :index, :edit, :update]
    resources 'stores', only: [:create, :new, :index, :edit, :update]
  end
end
