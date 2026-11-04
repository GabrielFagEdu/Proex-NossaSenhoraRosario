class CreateUsuarios < ActiveRecord::Migration[8.1]
  def change
    create_table :usuarios do |t|
      t.string :name
      t.string :email 
      t.string :senha

      t.timestamps
    end
  end
end
