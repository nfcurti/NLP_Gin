Rails.application.routes.draw do
  get 'browse/home'
  get 'contact/contact'
  root 'items#home'
  get '/signup', to: 'users#new'
  get '/contact', to: 'contact#contact'
  get    '/login',   to: 'sessions#new'
  get    '/browse',   to: 'browse#home'
  post   '/login',   to: 'sessions#create'
  post   '/subscribe',   to: 'checkout#new'
  delete   '/unsubscribe',   to: 'checkout#destroy'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  get "*path" => redirect("/")
  mount StripeEvent::Engine, at: '/hook' # provide a custom path
end