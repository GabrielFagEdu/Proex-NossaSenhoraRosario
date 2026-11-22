class CreateRelatorios < ActiveRecord::Migration[8.1]
  def change
    create_table :relatorios do |t|
      t.integer :id_pessoa
      t.string :tipo
      t.string :parametros
      t.date :data_geracao
      t.string :formato
      t.string :url_arquivo
      t.string :observacao
    end
  end
end
