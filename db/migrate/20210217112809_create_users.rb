class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :api_token
      t.boolean :is_admin, :default => false
      t.string :email

      t.timestamps
    end
  end
end
