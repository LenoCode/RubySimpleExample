require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Simple validation" do

    context "No valid examples" do
      it "Passing number to name column" do
        ruby_user = User.create name: 23 # Note for learning -> if added User.create! then test will fail, throw exception because it will run validation immediately and it will throw exception and proceeding to next code
        ruby_user.valid?
        expect(ruby_user.errors[":name"]).to include("Cant be number, only letters")
      end


    end
  end

end
