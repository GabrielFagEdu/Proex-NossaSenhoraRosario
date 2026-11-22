class Documento < ApplicationRecord
  self.table_name = "documentos"

  belongs_to :pessoa, foreign_key: :id_pessoa, inverse_of: :documentos
end