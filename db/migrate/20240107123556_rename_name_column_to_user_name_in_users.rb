class RenameNameColumnToUserNameInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :name, :user_name
  end
end
