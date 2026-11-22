class Matricula < ApplicationRecord
  self.table_name = "matricula"

  belongs_to :pessoa, foreign_key: :id_pessoa, inverse_of: :matriculas
  belongs_to :turma,  foreign_key: :id_turma,  inverse_of: :matriculas

  has_many :presencas, foreign_key: :id_matricula, inverse_of: :matricula, dependent: :destroy

  validates :id_pessoa, uniqueness: { scope: :id_turma }
end