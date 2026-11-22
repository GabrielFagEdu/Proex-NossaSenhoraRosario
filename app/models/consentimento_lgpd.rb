class ConsentimentoLgpd < ApplicationRecord
  self.table_name = "consentimento_lgpd"

  belongs_to :pessoa, foreign_key: :id_pessoa, inverse_of: :consentimentos_lgpd
end