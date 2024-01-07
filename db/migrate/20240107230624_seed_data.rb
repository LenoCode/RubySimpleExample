class SeedData < ActiveRecord::Migration[7.1]
  def change
    UserRole.create! name: "Author"
    UserRole.create! name: "Librarian"
    UserRole.create! name: "Member"

  end
end
