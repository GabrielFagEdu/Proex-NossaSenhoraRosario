class CreateMuralAviso < ActiveRecord::Migration[8.1]
  def change
    create_table :mural_aviso do |t|
      t.integer :id_pessoa
      t.string :titulo
      t.string :conteudo
      t.date :data_publicacao
      t.boolean :ativo
      t.string :observacao
    end
  end
end
