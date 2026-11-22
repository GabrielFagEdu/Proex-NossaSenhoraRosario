class MuralAviso < ApplicationRecord
  self.table_name = "mural_aviso"

  belongs_to :pessoa, foreign_key: :id_pessoa, inverse_of: :mural_avisos
end