class CreatePessoaPerfils < ActiveRecord::Migration[8.1]
  def change
    create_table :pessoa_perfils do |t|
      t.integer :id_pessoa
      t.integer :id_perfil
    end
  end
end
