class SeedBookData < ActiveRecord::Migration[7.1]
  def change
    user = User.create! name:"RubyAuthor"
    role = UserRole.find_by(name: "Author")
    XrefUserRole.create user:user, user_role:role

    Book.create! title:"Book1-life", copies: 120, author: user
    Book.create! title:"Book2-social", copies: 120, author: user
    Book.create! title:"Book3-code", copies: 120, author: user
    Book.create! title:"Book4-style", copies: 120, author: user

  end
end
