Rails.application.routes.draw do
  root 'mastermind#base'

  # owner
  get 'owner/new', to: 'owner#new', as: 'new_owner'
  get 'owner', to: 'mastermind#base'
  get 'owner/edit', to: 'owner#edit', as: 'edit_owner'
  post 'owner', to: 'owner#create'
  put 'owner', to: 'owner#update'
  patch 'owner', to: 'owner#update'

  # projects
  resources :projects
  patch 'projects/(:id)/toggle(.:format)', to: 'projects#toggle_active',
    as: 'change_active_status'

  # sessions
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
