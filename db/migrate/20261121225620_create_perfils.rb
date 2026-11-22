class CreatePerfils < ActiveRecord::Migration[8.1]
  def change
    create_table :perfils do |t|
      t.string :nome
    end
  end
end
