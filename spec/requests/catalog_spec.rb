require 'rails_helper'

RSpec.describe "Catalogs", type: :request do

  before(:all) do
    user = User.create! name:"RubyAuthor"
    role = UserRole.create!(name: "Author")
    XrefUserRole.create! user:user, user_role:role

    Book.create! title:"Book1-life", copies: 120, author: user
    Book.create! title:"Book2-social", copies: 120, author: user
    Book.create! title:"Book3-code", copies: 120, author: user


    apitoken = ApiToken.create!(user:user)
    apitoken.save

    @token = apitoken.token

  end


  describe "Basic search catalogs tests" do

    context "Simple search tests" do

      it 'Test simple search test wih both parameter correct (author and title)' do

        params = {
          "title":"Book1",
          "author":"Ruby"
        }
        get api_v1_catalog_search_path, params: params, headers: {'Authorization' => "Bearer #{@token}"}

        expect(response).to have_http_status(:ok)

        result = JSON.parse(response.body)

        expect(result["result"].length).to eql(1)

        expect(result["result"][0]["title"]).to eql("Book1-life")

      end

    end

  end



  after(:all) do
    Book.delete_all
    ApiToken.delete_all
    User.delete_all
  end

end
