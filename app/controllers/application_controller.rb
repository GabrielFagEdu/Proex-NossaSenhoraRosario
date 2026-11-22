class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :pessoa_atual, :logado?

  before_action :exigir_login

  private

  def pessoa_atual
    return if session[:pessoa_id].blank?

    @pessoa_atual ||= Pessoa.find_by(id: session[:pessoa_id], ativo: true)
  end

  def logado?
    pessoa_atual.present?
  end

  def exigir_login
    return if logado?

    reset_session
    redirect_to login_path, alert: "Faça login para continuar."
  end

  # Controle de acesso por perfil. Uso: before_action { exigir_perfil("Administrador") }
  def exigir_perfil(*nomes)
    return if nomes.any? { |nome| pessoa_atual&.tem_perfil?(nome) }

    redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
  end
end
