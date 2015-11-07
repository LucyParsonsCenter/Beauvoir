Borges::Application.routes.draw do
  get '/book/:isbn', :to => 'editions#byisbn'
  get '/book/', :to => 'editions#byisbn'

  get '/checkout', :to => 'sale_order#new'
  get '/sales_history', :to => 'sale_order#index'
  get '/dashboard/search', :to => 'dashboard#search'
  get '/dashboard/:action', :to => 'dashboard'
  get '/dashboard/', :to => 'dashboard#index'
  get '/sales/', :to => 'dashboard#sales'
  get '/losses/', :to => 'dashboard#losses'
  get '/consignment/', :to => 'dashboard#consignment'
  get '/ownerflow/', :to => 'dashboard#ownerflow'
  get '/purchases_by_date_and_owner/', :to => 'dashboard#purchases_by_date_and_owner'
  get '/inventory_value_by_date_and_owner/', :to => 'dashboard#inventory_value_by_date_and_owner'
  get '/inventory_report_by_owner/', :to => 'dashboard#inventory_report_by_owner'
  get '/daily/', :to => 'dashboard#daily', :as => "daily"
  get '/manage_calendar/', :to => 'dashboard#manage_calendar'
  get '/books/', :to => 'home#books'
  get '/library/', :to => 'library_book#index'

  #static pages
  get '/', :to => "static_page#home"
  get '/home', :to => "static_page#home"
  get '/help', :to => "static_page#help"
  get '/about', :to => "static_page#about"

  devise_for :users
  resources :users
end
