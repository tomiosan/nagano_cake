Rails.application.routes.draw do
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    root to: 'homes#top'
    resources :items, expect:[:destroy]
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_details, only:[:update]
  end

  root to: "public/homes#top"

  devise_for :customer, skip:[:passwords], controllers:{
    registrations: "customer/registrations",
    sessions: "customer/sessions"
  }

  scope module: :public do
    get "/about", to: "homes#about"
    get "/customers/unsubscribe", to: "customers#unsubscribe"
    patch "/customers/withdraw", to: "customers#withdraw"
    resource :customers, only:[:show, :edit, :update]
    resources :items, only:[:index, :show]
    resources :cart_items, except:[:show, :new, :edit]
    delete "/cart_items", to: "cart_items#destroy_all"
    resources :orders, except:[:edit, :update, :destroy] do
      collection do
        get "complete"
        post "confirm"
      end
    end
    resources :deliveries, except:[:new, :show]

    get '/genre_search', to: "searches#genre_search"
    get '/item_search', to: "searches#item_search"
   end
end