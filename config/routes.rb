Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/index'
  get 'welcome/about'

  devise_for :users, class_name: 'FormUser',
             :controllers => { omniauth_callbacks: 'omniauth_callbacks',
                               registrations: 'registrations'}

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end

  resources :feedback_messages
  resources :categories
  resources :comments

  resources :user do
    resources :items, only: :index
    resources :comments, only: :index
  end

  resources :items do
    resources :relationships, only: [:new, :create, :destroy]
  end

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :items
    resources :comments
    resources :users
    resources :categories
    # authenticate :user, lambda { |user| user.admin == true } do
    #   mount Sidekiq::Web, at: '/sidekiq'
    # end
  end

end