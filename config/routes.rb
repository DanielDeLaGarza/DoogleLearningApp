Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/search', to: 'doogle#search'
  get '/home', to: 'doogle#home'
  root 'doogle#home'
end
