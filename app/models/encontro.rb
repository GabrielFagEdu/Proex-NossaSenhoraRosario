class Encontro < ApplicationRecord
  self.table_name = "encontro"

  belongs_to :turma, foreign_key: :id_turma, inverse_of: :encontros

  has_many :presencas, foreign_key: :id_encontro, inverse_of: :encontro, dependent: :destroy
end