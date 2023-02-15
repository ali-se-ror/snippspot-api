Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users
      post 'users/sign_up', to: 'users#create'
      post 'users/log_in', to: 'sessions#login'
      resources :spots do
        collection do
          get :locations
          get :spots_by_location
          get :current_user_spots
        end
        resources :reviews
      end
    end
  end
end
