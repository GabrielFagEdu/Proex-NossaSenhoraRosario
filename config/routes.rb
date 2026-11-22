Rails.application.routes.draw do
  root "home#index"

  get "/login", to: "auth#login", as: :login
  post "/auth", to: "auth#logar", as: :auth
  delete "/logout", to: "auth#logout", as: :logout

  # Login com Google (a etapa de ida, POST /auth/google_oauth2, é tratada pelo OmniAuth)
  get "/auth/failure", to: "auth#falha"
  get "/auth/:provider/callback", to: "auth#omniauth"

  get "/signup", to: "signup#signup", as: :signup
  post "/signup", to: "signup#create"
end
