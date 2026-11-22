class CreateMatricula < ActiveRecord::Migration[8.1]
  def change
    create_table :matricula do |t|
      t.integer :id_pessoa
      t.integer :id_turma
      t.date :data_matricula
      t.string :status
      t.string :observacao
    end
  end
end
