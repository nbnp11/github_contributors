Rails.application.routes.draw do
  root 'statics#home'
  resources :contributors, only: :index
end
