Rails.application.routes.draw do

  get 'doogle/search'
  root 'doogle#search'
end
