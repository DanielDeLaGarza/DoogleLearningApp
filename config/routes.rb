Rails.application.routes.draw do
  post '/search', to: 'doogle#search'
  get '/home', to: 'doogle#home'
  root 'doogle#home'
end
