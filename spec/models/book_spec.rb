require 'rails_helper'

RSpec.describe Book, type: :model do

  before(:all) do

    user = User.create! name:"RubyAuthor"
    role = UserRole.create!(name: "Author")
    XrefUserRole.create! user:user, user_role:role

    Book.create! title:"Book1-life", copies: 120, author: user
    Book.create! title:"Book2-social", copies: 120, author: user
    Book.create! title:"Book3-code", copies: 120, author: user


  end

  describe "Simple validation" do

    context "Book creation, invalid examples" do

      it "Create book with user who is not author" do
        ruby_user = User.create name: "Ruby"
        expect(ruby_user).to be_valid

        ruby_book = Book.create title:"Ruby life", copies: 232, author:ruby_user
        expect(ruby_book.errors["roles"]).to include("This user does not have Author role")

      end

    end

    context "Book creation, valid examples" do

      it "Create book referenced to dummy user" do
        ruby_user = User.create name: "Ruby"
        expect(ruby_user).to be_valid
        ruby_user.save!

        authorRole = UserRole.create! name:"Author"
        authorRole.save!

        xrefUserRole = XrefUserRole.create! user: ruby_user, user_role: authorRole

        ruby_book = Book.create title:"Ruby life", copies: 232, author:ruby_user
        expect(ruby_book).to be_valid
      end

    end

  end


  describe "Book filtering" do

    context "Book title filtering" do

      it "Filter book by complete name" do
        book_name = "Book1-life"
        result = Book.filter_by_title(book_name)
        expect(result.size).to eq(1)

        result.each do |book|
          expect(book.title).to eq(book_name)
        end
      end

      it "Filter book by part name" do
        book_name = "Book"
        result = Book.filter_by_title(book_name)

        expect(result.size).to eq(3)
        result.each do |book|
          expect(book.title).to include(book_name)
        end
      end

      it "Filter book by part name title and part name author" do
        book_name = "Book1"
        author_name = "rub"

        result = Book.filter_by_title_and_author(book_name,author_name)
        expect(result.size).to eq(1)
        result.each do |book|
          expect(book.title).to include(book_name)
          expect(book.author.name).to include("RubyAuthor")
        end

      end

      it "Filter book by part name title and wrong author" do
        book_name = "Book1"
        author_name = "java"

        result = Book.filter_by_title_and_author(book_name,author_name)
        expect(result.size).to eq(0)

      end

    end

  end

  after(:all) do
    Book.delete_all
  end

end
