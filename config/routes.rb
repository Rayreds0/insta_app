Rails.application.routes.draw do
  root 'static_pages#about'

  get '/about' => 'static_pages#about'
  get '/help' => 'static_pages#help'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/password_resets/new' => 'password_resets#new'
  get '/password_resets/edit' => 'password_resets#edit'
  get 'home' => 'posts#home'

  resources :users
  resources :profiles, only: [:create, :edit, :update]
  resources :contacts, only: [:new, :index, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
