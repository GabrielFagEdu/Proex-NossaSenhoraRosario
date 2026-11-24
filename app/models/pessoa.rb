
class Pessoa < ApplicationRecord
  has_many :mural_avisos, foreign_key: :id_pessoa, inverse_of: :pessoa, dependent: :destroy
  has_many :relatorios, foreign_key: :id_pessoa, inverse_of: :pessoa, dependent: :destroy
  has_many :documentos, foreign_key: :id_pessoa, inverse_of: :pessoa, dependent: :destroy
  has_many :consentimentos_lgpd, class_name: "ConsentimentoLgpd", foreign_key: :id_pessoa, inverse_of: :pessoa, dependent: :destroy
  has_many :pessoa_perfis, class_name: "PessoaPerfil", foreign_key: :id_pessoa, inverse_of: :pessoa, dependent: :destroy
  has_many :perfis, through: :pessoa_perfis, source: :perfil
  # Pessoa como aluno matriculado
  has_many :matriculas, foreign_key: :id_pessoa, inverse_of: :pessoa, dependent: :destroy
  has_many :turmas_matriculadas, through: :matriculas, source: :turma
  # Pessoa como catequista
  has_many :turmas_como_catequista, class_name: "Turma", foreign_key: :id_catequista, inverse_of: :catequista, dependent: :nullify
  # Responsável <-> Aluno (auto-relacionamento N:N)
  has_many :vinculos_como_responsavel, class_name: "ResponsavelAluno", foreign_key: :id_responsavel, inverse_of: :responsavel, dependent: :destroy
  has_many :alunos, through: :vinculos_como_responsavel, source: :aluno
  has_many :vinculos_como_aluno, class_name: "ResponsavelAluno", foreign_key: :id_aluno, inverse_of: :aluno, dependent: :destroy
  has_many :responsaveis, through: :vinculos_como_aluno, source: :responsavel

  # Adapta o has_secure_password à coluna definida no DER.
  alias_attribute :senha_digest, :senha_hash
  has_secure_password :senha

  # Validações
  validates :nome, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :senha, length: { minimum: 8 }, allow_nil: true

  before_validation :normalizar_email

  # Cria ou localiza a pessoa a partir do retorno do Google (OmniAuth).
  def self.from_omniauth(auth)
    email = auth.info.email.to_s.strip.downcase
    return nil if email.blank? || auth.info.email_verified == false

    pessoa = find_by(provider: auth.provider, uid: auth.uid) || find_by(email: email)

    if pessoa
      pessoa.update(provider: auth.provider, uid: auth.uid) if pessoa.provider.blank?
      pessoa
    else
      create(
        nome: auth.info.name.presence || email,
        email: email,
        provider: auth.provider,
        uid: auth.uid,
        data_cadastro: Date.current,
        senha: SecureRandom.hex(24) # senha aleatória: o acesso é pelo Google
      )
    end
  end

  def tem_perfil?(nome)
    perfis.exists?(nome: nome)
  end

  private

  def normalizar_email
    self.email = email.to_s.strip.downcase
  end
end
