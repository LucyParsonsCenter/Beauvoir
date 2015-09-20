Borges::Application.routes.draw do

  resources :inventory_copy_confirmations do 
    member do
      post :probablyreturned
    end
  end

  resources :inventories do
    member do 
      get :section
      get :owner
      post :fill
      post :fill_books
    end
  end

  resources :category_title_list_memberships

  resources :sale_order_line_items
 
  resources :sale_orders do
    member do
      post :post
    end
  end

  resources :return_order_line_items
 
  resources :return_orders do
    member do
      post :post
    end

  end

  resources :owners do
    get :autocomplete_owner_name, :on => :collection
  end

  resources :title_category_memberships
  resources :categories
  resources :title_list_memberships

  resources :title_lists do 
    get :autocomplete_title_title, :on => :collection
    get :autocomplete_title_list_name, :on => :collection
  end

  resources :images

  mount Ckeditor::Engine => '/ckeditor'

  resources :publishers do 
    member do
      put :merge_editions_from
    end
  end

  resources :customers do 
    get :autocomplete_customer_name, :on => :collection
  end

  resources :distributors do
    member do
      put :merge_orders_from
      get :chart
    end
  end

  resources :invoice_line_items

  get 'invoices/chart' => 'invoices#chart'
  resources :invoices do
    member do
      post :receive
    end
  end

  resources :purchase_order_line_items do 
    member do
      get :hidden_actions 
      put :move_to_purchase_order
    end
  end

  resources :purchase_orders do 
    member do
      post :submit
      post :receive
    end
    get :autocomplete_distributor_name, :on => :collection
    resources :purchase_order_line_items
  end

  resources :copies do 
    get :autocomplete,:on => :collection
    get :inventory_autocomplete,:on => :collection
    member do
      post :mark_lost
    end

  end

  resources :editions do
    resources :copies
    get :autocomplete,:on => :collection
    get :autocomplete_title_title, :on => :collection
    member do
      get :hidden_actions 
      put :add_to_purchase_order
      put :add_to_title_list
      put :add_to_category
    end
  end

  resources :contributions do 
    get :autocomplete_author_full_name, :on => :collection
  end

  get 'titles/search' => 'titles#search'
  resources :titles do 
    get :autocomplete_publisher_name, :on => :collection
    get :autocomplete_distributor_name, :on => :collection
    get :autocomplete_title_list_name, :on => :collection
    get :autocomplete_category_name, :on => :collection
  end
  
  get 'authors/search' => 'authors#search'
  resources :authors

  resources :shopping_carts do
    member do
      post :complete
      post :defer
      post :subscribe
    end
  end
  resources :shopping_cart_line_items

  get '/book/:isbn', :to => 'editions#byisbn'
  get '/book/', :to => 'editions#byisbn'

  get '/checkout', :to => 'home#checkout'
  get '/help', :to => 'home#help'
  get '/dashboard/search', :to => 'dashboard#search'
  get '/dashboard/:action', :to => 'dashboard'
  get '/dashboard/', :to => 'dashboard#index'
  get '/content/', :to => 'dashboard#content'
  get '/sales/', :to => 'dashboard#sales'
  get '/losses/', :to => 'dashboard#losses'
  get '/events_calendar', :to => 'events#calendar'
  get '/consignment/', :to => 'dashboard#consignment'
  get '/ownerflow/', :to => 'dashboard#ownerflow'
  get '/purchases_by_date_and_owner/', :to => 'dashboard#purchases_by_date_and_owner'
  get '/inventory_value_by_date_and_owner/', :to => 'dashboard#inventory_value_by_date_and_owner'
  get '/inventory_report_by_owner/', :to => 'dashboard#inventory_report_by_owner'
  get '/daily/', :to => 'dashboard#daily', :as => "daily"
  get '/manage_calendar/', :to => 'dashboard#manage_calendar'
  get '/books/', :to => 'home#books'
  get '/food/', :to => 'home#food'
  get '/coffee/', :to => 'home#thread'
  get '/thread/', :to => 'home#thread'
  get '/blog/', :to => 'posts#index'
  get '/about/', :to => 'home#about'
  get '/2640/', :to => 'events#twentysixforty'
  get '/newsletter/', :to => 'home#newsletter'
  get '/pages/about/', :to => 'home#about'
  get '/cart', :to => "shopping_carts#current"
  put '/update_cart', :to => "shopping_carts#update_current"
  get '/', :to => "home#frontpage"

  devise_for :users
  resources :users
end
