Rails.application.routes.draw do
  root 'mastermind#base'
  resources :owner, only: [:new, :create]
  post 'owners', to: 'owner#create'
  get 'owners', to: 'mastermind#base'
end
