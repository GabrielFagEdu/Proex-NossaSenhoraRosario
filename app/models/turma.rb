class Turma < ApplicationRecord
  self.table_name = "turma"

  belongs_to :catequista, class_name: "Pessoa", foreign_key: :id_catequista,
             inverse_of: :turmas_como_catequista, optional: true

  has_many :encontros,  foreign_key: :id_turma, inverse_of: :turma, dependent: :destroy
  has_many :matriculas, foreign_key: :id_turma, inverse_of: :turma, dependent: :destroy
  has_many :alunos, through: :matriculas, source: :pessoa
end