class Book < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validate :validate_book

  private

  def validate_book
    user = User.find_by(id: author_id)
    roles = XrefUserRole.joins(:user).joins(:user_role).where("users.name = ?", user.name).where("user_roles.name= ?","Author")
    errors.add("roles","This user does not have Author role") if roles.empty?
  end
end
