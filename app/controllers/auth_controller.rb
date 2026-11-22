class AuthController < ApplicationController
  skip_before_action :exigir_login

  def login
    redirect_to root_path if logado?
  end

  def logar
    email = params[:email].to_s.strip.downcase
    senha = params[:senha].to_s

    pessoa = Pessoa.find_by(email: email)

    if pessoa&.ativo? && pessoa.authenticate_senha(senha)
      iniciar_sessao(pessoa, lembrar: params[:remember] == "1")

      redirect_to root_path, notice: "Login realizado com sucesso."
    else
      redirect_to login_path, alert: "E-mail ou senha inválidos."
    end
  end

  # Callback do Google: GET /auth/google_oauth2/callback
  def omniauth
    pessoa = Pessoa.from_omniauth(request.env["omniauth.auth"])

    if pessoa&.persisted? && pessoa.ativo?
      novo_cadastro = pessoa.previously_new_record?

      EmailApi.cadastro_criado(pessoa) if novo_cadastro
      iniciar_sessao(pessoa, lembrar: true, avisar: !novo_cadastro)

      redirect_to root_path, notice: "Login realizado com sucesso."
    else
      redirect_to login_path, alert: "Não foi possível entrar com o Google."
    end
  end

  def falha
    redirect_to login_path, alert: "Falha na autenticação com o Google."
  end

  def logout
    reset_session

    redirect_to login_path, notice: "Você saiu da sua conta."
  end

  private

  def iniciar_sessao(pessoa, lembrar: false, avisar: true)
    reset_session
    session[:pessoa_id] = pessoa.id
    request.session_options[:expire_after] = 30.days if lembrar

    EmailApi.novo_login(pessoa, request) if avisar
  end
end