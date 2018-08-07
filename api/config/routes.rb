Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :dogs
      resources :owners, only: [:show, :index]
      resources :sitters, only: [:show, :index]
      resources :reviews, only: [:show, :index, :post]
    end
  end

end
