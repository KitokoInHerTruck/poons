
Rails.application.routes.draw do
  mount SolidusPaypalCommercePlatform::Engine, at: '/solidus_paypal_commerce_platform'

  root to: 'home#index'

    get '/events', to: 'admin/events#index', as: 'events'
    get '/events/:id', to: 'admin/events#events_show', as: 'event'

  namespace :admin do
    resources :elevages
      resources :events do
        post 'subscribe', on: :member
        post 'unsubscribe', on: :member
      end
  end

  get '/t/categories/elevage', to: redirect('/'), as: 'elevage'
  # sans cette première lignes j'ai la colonne de commerce
  get '/t/categories/cours', to: 'admin/events#index', as: 'user_events_show'
 get '/admin/events', to: 'admin/events#new_admin_event', as: 'new_events'
  get '/events/:event_id/registrations/new', to: 'event_registrations#new', as: 'new_event_registration'
  post '/events/:event_id/subscribe', to: 'events#subscribe', as: 'event_subscribe'
  delete '/events/:event_id/unsubscribe', to: 'events#unsubscribe', as: 'event_unsubscribe'

  devise_for(:user, {
    class_name: 'Spree::User',
    singular: :spree_user,
    controllers: {
      sessions: 'user_sessions',
      registrations: 'user_registrations',
      passwords: 'user_passwords',
      confirmations: 'user_confirmations'
    },
    skip: [:unlocks, :omniauth_callbacks],
    path_names: { sign_out: 'logout' }
  })

  namespace :tenues, path: '/products' do
    resources :products
    resources :orders
  end

  resources :users, only: [:edit, :update]

  devise_scope :spree_user do
    get '/login', to: 'user_sessions#new', as: :login
    post '/login', to: 'user_sessions#create', as: :create_new_session
    match '/logout', to: 'user_sessions#destroy', as: :logout, via: Devise.sign_out_via
    match '/signup', to: 'user_registrations#new', via: [:get, :post], as: :signup
    post '/signup', to: 'user_registrations#create', as: :registration
    get '/password/recover', to: 'user_passwords#new', as: :recover_password
    post '/password/recover', to: 'user_passwords#create', as: :reset_password
    get '/password/change', to: 'user_passwords#edit', as: :edit_password
    put '/password/change', to: 'user_passwords#update', as: :update_password
    get '/confirm', to: 'user_confirmations#show', as: :confirmation if Spree::Auth::Config[:confirmable]
  end

  resource :account, controller: 'users'

  resources :products, only: [:index, :show]

  resources :cart_line_items, only: :create

  get '/locale/set', to: 'locale#set'
  post '/locale/set', to: 'locale#set', as: :select_locale

  resource :checkout_session, only: :new
  resource :checkout_guest_session, only: :create

  # non-restful checkout stuff
  patch '/checkout/update/:state', to: 'checkouts#update', as: :update_checkout
  get '/checkout/:state', to: 'checkouts#edit', as: :checkout_state
  get '/checkout', to: 'checkouts#edit', as: :checkout

  get '/orders/:id/token/:token' => 'orders#show', as: :token_order

  resources :orders, only: :show do
    resources :coupon_codes, only: :create
  end

  resource :cart, only: [:edit, :update] do
    put 'empty'
  end

  # route globbing for pretty nested taxon and product paths
  get '/t/*id', to: 'taxons#show', as: :nested_taxons

  get '/unauthorized', to: 'home#unauthorized', as: :unauthorized
  get '/cart_link', to: 'store#cart_link', as: :cart_link

  get '*path', to: redirect('/tenues_d_equitation/%{path}'), constraints: lambda { |req|
  req.path.start_with?('/products') || req.path.start_with?('/orders')
  }

  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
   mount Spree::Core::Engine, at: '/'
end