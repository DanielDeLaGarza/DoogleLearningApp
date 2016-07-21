Rails.application.routes.draw do
  get 'doogle/home'
  root 'doogle#home'
  post '/search', to: 'doogle#search'
end
