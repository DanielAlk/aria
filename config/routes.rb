Rails.application.routes.draw do

  constraints subdomain: lambda { |sd| !sd[/stage/] && !sd[/panel/] } do
    get '(*soon)', to: 'pages#soon'
  end

  constraints subdomain: /panel/ do
    get '/', to: 'panel#admin', as: :panel

    devise_for :admins, controllers: {
      registrations: 'admins/registrations',
      sessions: 'admins/sessions',
      passwords: 'admins/passwords'
    }

    resources :websites, :defaults => { :format => :json }, only: [:show, :update]
    
    resources :users

    resources :articles, path: '(:shape)/articles', only: [:index, :new]
    resources :articles, except: [:index, :new] do
      collection do
        put '/', action: :update_many, :defaults => { :format => :json }
      end
    end

    resources :categories
    resources :images, :defaults => { :format => :json } do
      collection do
        put '/', action: :update_many
      end
    end
    resources :tags
    resources :zones, only: [:index, :update]
    resources :products do
      collection do
        put '/', action: :update_many
        delete '/', action: :destroy_many
      end
      member do
        post '/clone', action: :clone
      end
    end
  end

  constraints subdomain: lambda { |sd| !sd[/panel/] } do
    get 'profile', to: 'panel#profile', as: :profile

    devise_for :users, path: 'profile', controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      passwords: 'users/passwords'
    }

    resources :addresses, path: 'profile/direcciones'
    resources :reviews, path: 'profile/reviews'

    resource :cart, :defaults => { :format => :json }, only: [:show] do
      get 'stock', to: 'carts#stock', as: :product_stock
      put 'add', to: 'carts#add', as: :add_to
      put 'remove', to: 'carts#remove', as: :remove_from
    end
  end

  resources :payments, only: [ :index, :show, :create ]

  root 'pages#home'

  get 'home', to: 'pages#home', as: :home
  get 'catalogo/(:category_id)', to: 'pages#products', as: :products_page
  get 'tag/:tag_id', to: 'pages#tag', as: :tag_page
  get 'producto/:product_id', to: 'pages#product', as: :product_page
  get 'carrito', to: 'pages#cart', as: :cart_page
  get 'checkout', to: 'pages#checkout', as: :checkout_page
  get 'confirmar', to: 'pages#confirm', as: :confirm_page
  get 'partners', to: 'pages#partners', as: :partners_page
  get 'servicios/:article_id', to: 'pages#services', as: :service_page
  get 'la-empresa', to: 'pages#about', as: :about_page
  get 'noticias', to: 'pages#news', as: :news_page
  get 'articulo/:article_id', to: 'pages#article', as: :article_page
  get 'contacto', to: 'pages#contact', as: :contact_page

end