Rails.application.routes.draw do
  root 'searches#home'
  post 'search', to: 'searches#search'
  resources :repos, only: :show #:index
  resources :contributors, only: :show
end
