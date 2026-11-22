class CreateDocumentos < ActiveRecord::Migration[8.1]
  def change
    create_table :documentos do |t|
      t.integer :id_pessoa
      t.string :tipo_documento
      t.string :nome_arquivo
      t.date :data_upload
      t.string :status_analise
      t.string :observacao
    end
  end
end
