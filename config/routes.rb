Rails.application.routes.draw do
  get 'contact/contact'
  root 'items#home'
  get '/signup', to: 'users#new'
  get '/contact', to: 'contact#contact'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end