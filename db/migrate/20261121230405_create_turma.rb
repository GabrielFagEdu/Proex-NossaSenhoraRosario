class CreateTurma < ActiveRecord::Migration[8.1]
  def change
    create_table :turma do |t|
      t.string :nome
      t.string :descricao
      t.string :fase
      t.string :dia_semana
      t.string :horario_inicio
      t.string :horario_fim
      t.integer :vagas
      t.string :status
      t.integer :id_catequista
    end
  end
end
