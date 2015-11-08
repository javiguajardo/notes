Rails.application.routes.draw do
  resources :tasks, except: [:show]
  resources :courses
  resources :roles
  resources :notebooks
  devise_for :users
  get 'home/index'

  resources :notes

  namespace :admin do
    # get "/stats" => "stats#stats"
    devise_scope :admin_user do
      get '/stats/:scope' => "stats#stats", as: :admin_stats
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticated :user do
    root "notes#index", as: "authenticated_root"
  end

  root "home#index", as: 'unauthenticated_root'
end
