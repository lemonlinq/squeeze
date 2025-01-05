Rails.application.routes.draw do
  Rails.application.routes.draw do
    root 'links#index'
    resources :links, only: [:create]
    get '/:short_url', to: 'links#redirect', as: :short
  end
end
