Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'hunters#show'
  resource :hunter, except: [:index] do
    collection do
      get 'progress'
      get 'hunting'
      get 'team'
    end
  end
  get     '/profile', to: 'hunters#show'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  match   '/forgot_password', to: 'sessions#forgot_password', via: [:get,:post]
  match   '/reset_password/:reset_token',  to: 'sessions#reset_password',  via: [:get,:post], as: 'reset_password'

  get     '/signup',  to: 'hunters#new'
  post    '/signup',  to: 'hunters#create'
end
