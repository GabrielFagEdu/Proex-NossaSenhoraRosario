class PessoaPerfil < ApplicationRecord
  self.table_name = "pessoa_perfils"

  belongs_to :pessoa, foreign_key: :id_pessoa, inverse_of: :pessoa_perfis
  belongs_to :perfil, foreign_key: :id_perfil, inverse_of: :pessoa_perfis

  validates :id_perfil, uniqueness: { scope: :id_pessoa }
end