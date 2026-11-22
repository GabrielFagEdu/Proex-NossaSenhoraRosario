class CreateConsentimentoLgpd < ActiveRecord::Migration[8.1]
  def change
    create_table :consentimento_lgpd do |t|
      t.integer :id_pessoa
      t.string :aceite
      t.date :data_aceite
      t.string :versao_termo
      t.boolean :revogado
      t.date :data_revogado
    end
  end
end
