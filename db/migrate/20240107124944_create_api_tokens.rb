class CreateApiTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :api_tokens do |t|
      t.text :token, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
