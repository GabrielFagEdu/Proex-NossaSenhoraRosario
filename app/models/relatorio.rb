class Relatorio < ApplicationRecord
  self.table_name = "relatorios"

  belongs_to :pessoa, foreign_key: :id_pessoa, inverse_of: :relatorios
end