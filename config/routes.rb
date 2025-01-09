Rails.application.routes.draw do

  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  resource :profile, only: [:show, :edit, :update]

  devise_for :users

  root 'links#index'

  resources :links, only: [:index, :create]
  get '/:short_url', to: 'links#redirect', as: :short
end
