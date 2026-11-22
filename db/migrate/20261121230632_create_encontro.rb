class CreateEncontro < ActiveRecord::Migration[8.1]
  def change
    create_table :encontro do |t|
      t.integer :id_turma
      t.date :data_encontro
      t.string :tema
      t.string :descricao
    end
  end
end
