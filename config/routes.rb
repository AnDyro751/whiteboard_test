Rails.application.routes.draw do
  devise_for :users
  get "/step/:step", to: "characters#new", as: "new_character"
  post "/next_step", to: "characters#next_step", as: "next_step"
  post "/create", to: "characters#create", as: :create
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
