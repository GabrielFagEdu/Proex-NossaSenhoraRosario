class SignupController < ApplicationController
  skip_before_action :exigir_login

  def signup
    redirect_to root_path and return if logado?

    @pessoa = Pessoa.new
  end

  def create
    @pessoa = Pessoa.new(pessoa_params.merge(data_cadastro: Date.current))

    if @pessoa.save
      reset_session
      session[:pessoa_id] = @pessoa.id

      EmailApi.cadastro_criado(@pessoa)

      redirect_to root_path, notice: "Cadastro realizado com sucesso."
    else
      flash.now[:alert] = @pessoa.errors.full_messages.to_sentence
      render :signup, status: :unprocessable_entity
    end
  end

  private

  def pessoa_params
    params.expect(pessoa: [ :nome, :email, :senha, :senha_confirmation ])
  end
end