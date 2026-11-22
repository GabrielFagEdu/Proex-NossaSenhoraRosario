class Presenca < ApplicationRecord
  self.table_name = "presenca"

  belongs_to :encontro,  foreign_key: :id_encontro,  inverse_of: :presencas
  belongs_to :matricula, foreign_key: :id_matricula, inverse_of: :presencas

  validates :id_matricula, uniqueness: { scope: :id_encontro }
end