Rails.application.routes.draw do
  root "tickets#index"

  resources :tickets do
   member do
    patch :resolve
    get :attachment
   end
 end

  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create", as: :session
  delete "/logout", to: "sessions#destroy", as: :logout
  namespace :api do
  namespace :v1 do
    resources :tickets, only: %i[index show create update]
  end
end
end