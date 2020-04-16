Rails.application.routes.draw do
  root 'mastermind#base'
  resources :owner, only: [:new, :create]
end
