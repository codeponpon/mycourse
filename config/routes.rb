Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'user_root', to: redirect('/users/edit'), as: :user_root
  resources :courses do
    collection do
      post '/search', to: 'courses#search'
    end
  end
  root to: "home#index"
end
