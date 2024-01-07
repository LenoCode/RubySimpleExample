class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :copies
      t.references :author, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
