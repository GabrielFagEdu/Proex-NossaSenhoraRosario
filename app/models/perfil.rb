class Perfil < ApplicationRecord
  self.table_name = "perfils"

  has_many :pessoa_perfis, class_name: "PessoaPerfil",
           foreign_key: :id_perfil, inverse_of: :perfil, dependent: :destroy
  has_many :pessoas, through: :pessoa_perfis
end