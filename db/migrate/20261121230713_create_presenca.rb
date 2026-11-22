class CreatePresenca < ActiveRecord::Migration[8.1]
  def change
    create_table :presenca do |t|
      t.integer :id_encontro
      t.integer :id_matricula
      t.boolean :presente
      t.string :observacao
    end
  end
end
