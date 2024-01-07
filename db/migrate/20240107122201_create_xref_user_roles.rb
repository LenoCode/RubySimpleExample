class CreateXrefUserRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :xref_user_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
