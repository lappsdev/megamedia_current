require 'sidekiq/web'
require 'sidekiq-scheduler/web'
Rails.application.routes.draw do
  get  'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get  'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]

  root 'home#index'
  get '404', to: 'home#index'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  mount VandalUi::Engine, at: '/vandal'
  resources :units do
    resources :devices, only: %i[create new]
    resources :departments, only: %i[create new]
  end
  resources :departments

  resources :devices
  resources :screens
  resources :users
  resources :attachments

  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :schedulers
    resources :password_caller_widgets
    resources :ssh_commands
    resources :product_table_widgets
    resources :queue_caller_widgets

    resources :products
    resources :price_checker_widgets
    resources :video_widgets
    resources :medias
    resources :attachments
    resources :image_widgets
    resources :users
    resources :widgets
    resources :screens
    resources :devices
    resources :units
    resources :groups
    resources :credentials
    resources :departments

    # your routes go here
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
