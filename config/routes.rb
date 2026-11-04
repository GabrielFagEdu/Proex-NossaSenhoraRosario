Rails.application.routes.draw do
  root "auth#login"

  post "/auth", to: "auth#logar"
end