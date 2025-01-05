Rails.application.routes.draw do
  devise_for :users

  root 'links#index'

  resources :links, only: [:create]
  get '/:short_url', to: 'links#redirect', as: :short
end
