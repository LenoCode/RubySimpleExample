require 'rails_helper'

RSpec.describe Book, type: :model do


  describe "Simple validation" do


    context "Book creation, valid examples" do

      it "Create book referenced to dummy user" do
        ruby_user = User.create name: "Ruby"
        expect(ruby_user).to be_valid

        ruby_book = Book.create title:"Ruby life", copies: 232, author:ruby_user
        expect(ruby_book).to be_valid
      end

    end

  end

end
