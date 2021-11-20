Rails.application.routes.draw do
  resources :notebooks do
    resources :pages
  end
  devise_for :users
  root to: "home#index"
end
