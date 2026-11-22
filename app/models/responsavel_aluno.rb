class ResponsavelAluno < ApplicationRecord
  self.table_name = "responsavel_alunos"

  belongs_to :responsavel, class_name: "Pessoa", foreign_key: :id_responsavel, inverse_of: :vinculos_como_responsavel
  belongs_to :aluno, class_name: "Pessoa", foreign_key: :id_aluno, inverse_of: :vinculos_como_aluno

  validates :id_aluno, uniqueness: { scope: :id_responsavel }
end