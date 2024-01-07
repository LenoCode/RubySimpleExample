require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "User token authorization" do

    context "Users without valid token" do

      it "Going to page user/create without valid token and without proper payload" do
        post api_v1_user_create_path, headers: {HTTP_AUTHORIZATION: "Token token=Bearer not valid token"}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "Going to page user/create without valid token and without proper name setup" do
        user_params = {
          user:{
            name:"1234"
          }
        }
        post api_v1_user_create_path, headers: {HTTP_AUTHORIZATION: "Token token=Bearer not valid token"}, params:user_params
        expect(response).to have_http_status(:unprocessable_entity)

        response_body = JSON.parse(response.body)

        expect(response_body["errors"]["name"][0]).to eq("Cant be number, only letters")

      end

    end

  end
end
