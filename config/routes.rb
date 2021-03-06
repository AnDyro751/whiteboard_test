Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
  get "/step/:step", to: "characters#new", as: "new_step"
  post "/next-step", to: "characters#next_step", as: "next_step"
  post "/create", to: "characters#create", as: :create
  post "/switch-locale",to: "home#switch_locale", as: :switch_locale
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
