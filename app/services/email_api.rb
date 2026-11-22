require "net/http"
require "json"

# Cliente da API de e-mails. O envio acontece em segundo plano para não
# atrasar login/cadastro, e qualquer falha é apenas registrada no log.
class EmailApi
  URL = ENV.fetch("EMAIL_API_URL", "http://18.188.254.136:8085/api/email/enviar")

  class << self
    def cadastro_criado(pessoa)
      mensagem = <<~TEXTO
        Olá, #{pessoa.nome}!

        Seu cadastro no SaintStudy foi criado com sucesso.

        Agora você já pode acessar o portal com o e-mail #{pessoa.email}.

        Se você não realizou este cadastro, ignore esta mensagem ou entre em contato com a secretaria.
      TEXTO

      enviar(
        destinatario: pessoa.email,
        assunto: "Cadastro criado com sucesso - SaintStudy",
        mensagem: mensagem
      )
    end

    def novo_login(pessoa, request)
      quando = Time.current.in_time_zone("Brasilia").strftime("%d/%m/%Y às %H:%M")

      mensagem = <<~TEXTO
        Olá, #{pessoa.nome}!

        Detectamos um novo login na sua conta do SaintStudy.

        Data e hora: #{quando}
        Endereço IP: #{request.remote_ip}
        Navegador: #{request.user_agent}

        Se foi você, não precisa fazer nada.
        Se não reconhece este acesso, altere sua senha o quanto antes.
      TEXTO

      enviar(
        destinatario: pessoa.email,
        assunto: "Novo login na sua conta - SaintStudy",
        mensagem: mensagem
      )
    end

    private

    def enviar(destinatario:, assunto:, mensagem:)
      return if Rails.env.test?

      token = ENV["EMAIL_API_TOKEN"]
      if token.blank?
        Rails.logger.warn("[EmailApi] EMAIL_API_TOKEN não definido; e-mail não enviado")
        return
      end

      Thread.new do
        Rails.application.executor.wrap do
          enviar_agora(destinatario, assunto, mensagem, token)
        end
      end

      nil
    end

    def enviar_agora(destinatario, assunto, mensagem, token)
      uri = URI(URL)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = 5
      http.read_timeout = 30

      requisicao = Net::HTTP::Post.new(
        uri,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{token}"
      )
      requisicao.body = { destinatario: destinatario, assunto: assunto, mensagem: mensagem }.to_json

      resposta = http.request(requisicao)

      unless resposta.is_a?(Net::HTTPSuccess)
        Rails.logger.error("[EmailApi] Falha ao enviar (HTTP #{resposta.code}): #{resposta.body.to_s.truncate(200)}")
      end
    rescue StandardError => e
      Rails.logger.error("[EmailApi] Erro ao enviar e-mail: #{e.class} - #{e.message}")
    end
  end
end