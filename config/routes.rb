Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: %i[index show create]
      resources :users, only: %i[create]
      resource :auth, only: [] do
        post '/login', to: 'authentication#login'
      end
    end
  end
end
