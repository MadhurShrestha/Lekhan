Rails.application.routes.draw do
  resources :notebooks do
    resources :pages do
      resources :paragraphs
      resources :image_elements
      resources :checklists do
        resources :checklist_items
      end
    end
  end
  devise_for :users
  get 'home', to: 'home#index'
  root to: "notebooks#index"

devise_scope :user do
  get   "/check_session_timeout"    => "session_timeout#check_session_timeout"
  get   "/session_timeout"          => "session_timeout#render_timeout"
end
end
