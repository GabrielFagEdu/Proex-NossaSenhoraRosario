class AuthController < ApplicationController
  def login
  end

  def logar
    usuario = Usuario.find_by(email: params[:email])

    if usuario && usuario.senha == params[:senha]
      session[:usuario_id] = usuario.id

      redirect_to root_path, notice: "Login realizado com sucesso."
    else
      redirect_to root_path, alert: "E-mail ou senha inválidos."
    end
  end
end