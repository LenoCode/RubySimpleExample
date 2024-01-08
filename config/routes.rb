Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        #User controlller
        post "user/create", to: "user#create"
        get  "user/valid/token", to: "user#is_valid_token"
        post "user/role/add", to: "user#add_user_role"
        #---------------------------------------

        #Catalog controller
        get "catalog/search", to: "catalog#search_books"
        #---------------------------------------

      end
    end
  end

end
