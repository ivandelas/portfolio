Rails.application.routes.draw do
  root 'mastermind#base'
  get 'owner/new', to: 'owner#new', as: 'new_owner'
  post 'owner', to: 'owner#create'
  get 'owner', to: 'mastermind#base'
  resources :projects
end
