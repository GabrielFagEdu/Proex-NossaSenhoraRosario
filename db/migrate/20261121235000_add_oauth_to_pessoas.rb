class AddOauthToPessoas < ActiveRecord::Migration[8.1]
  def change
    add_column :pessoas, :provider, :string
    add_column :pessoas, :uid, :string

    add_index :pessoas, [ :provider, :uid ], unique: true
  end
end
