Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      get    'session/show',    controller: 'session', action: :show
      post   'session/create',  controller: 'session', action: :create
      delete 'session/destroy', controller: 'session', action: :destroy
    end
  end
  get 'home/index'

  root 'home#index'
  get '*path', to: 'home#index', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
