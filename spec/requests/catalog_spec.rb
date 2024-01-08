require 'rails_helper'

RSpec.describe "Catalogs", type: :request do

  before(:all) do
    user = User.create! name:"RubyAuthor"
    role = UserRole.create!(name: "Author")
    XrefUserRole.create! user:user, user_role:role

    Book.create! title:"Book1-life", copies: 120, author: user
    Book.create! title:"Book2-social", copies: 120, author: user
    Book.create! title:"Book3-code", copies: 120, author: user
  end


  describe "Basic search catalogs tests" do

    context "Simple search tests" do

      it 'Test simple search test wih both parameter correct (author and title)' do

        params = {
          "title":"Book",
          "author":"Ruby"
        }

        get api_v1_catalog_search_path params: params

        expect(response).to have_http_status(:ok)

        result = JSON.parse(response.body)


        expect(result["list"].length).to eql(0)


      end

    end

  end



  after(:all) do
    Book.delete_all
  end

end
