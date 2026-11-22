class CreatePessoas < ActiveRecord::Migration[8.1]
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :email
      t.string :senha_hash
      t.string :telefone
      t.boolean :ativo, default: true, null: false
      t.date :data_cadastro
      t.string :observacao
    end

    add_index :pessoas, :email, unique: true
  end
end
