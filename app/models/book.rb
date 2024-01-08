class Book < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validate :validate_book

=begin
    Simple method to filter by title.
    If book bas title Book1 and parameter title is Book, then that book will
    be found
=end
  def self.filter_by_title(title)
    where("LOWER(title) LIKE ?", "%#{title}%")
  end


=begin
 Simple method to filter by title and author.
   If book bas title Book1 and parameter title is Book, then that book will.
   Also if author is not nil, then it will filter through that also
 be found
=end
  def self.filter_by_title_and_author(title,author)
    result = where("LOWER(title) LIKE ?", "%#{title}%")
    if !author.nil?
      return result.joins(:author).where("LOWER(users.name) LIKE ?","%#{author}%")
    end
    result
  end

  private

  def validate_book
    user = User.find_by(id: author_id)
    roles = XrefUserRole.joins(:user).joins(:user_role).where("users.name = ?", user.name).where("user_roles.name= ?","Author")
    errors.add("roles","This user does not have Author role") if roles.empty?
  end
end
