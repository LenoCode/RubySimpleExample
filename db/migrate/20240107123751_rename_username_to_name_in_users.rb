class RenameUsernameToNameInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :user_name, :name
  end
end
