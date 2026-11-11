Rails.application.routes.draw do
  root "auth#login"

  post "/auth", to: "auth#logar", as: :auth

  get "/login", to: "auth#login", as: :login

  get "/signup", to: "signup#signup", as: :signup
end