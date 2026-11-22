class CreateResponsavelAlunos < ActiveRecord::Migration[8.1]
  def change
    create_table :responsavel_alunos do |t|
      t.integer :id_aluno
      t.integer :id_responsavel
      t.string :principal
    end
  end
end
