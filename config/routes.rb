Rails.application.routes.draw do

  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  resource :profile, only: [:show, :edit, :update]

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'links#index'

  resources :links, only: [:index, :create]

  resources :subscriptions, only: [:new, :create]
  get '/:short_url', to: 'links#redirect', as: :short
end
