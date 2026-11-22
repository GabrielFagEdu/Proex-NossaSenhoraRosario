# Credenciais criadas no Google Cloud Console (APIs e serviços > Credenciais).
# URI de redirecionamento autorizado: http://localhost:3000/auth/google_oauth2/callback
google_client_id = Rails.application.credentials.dig(:google, :client_id)     || ENV["GOOGLE_CLIENT_ID"]
google_client_secret = Rails.application.credentials.dig(:google, :client_secret) || ENV["GOOGLE_CLIENT_SECRET"]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, google_client_id, google_client_secret,
           scope: "email,profile",
           prompt: "select_account"
end

OmniAuth.config.logger = Rails.logger
