Rails.application.routes.draw do
  root 'searches#home'
  post 'search', to: 'searches#search'
  resources :repos, only: :show do
    member do
      get :download_zip
    end
  end

  resources :contributors, only: :show
end
