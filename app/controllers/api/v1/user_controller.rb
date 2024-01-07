# frozen_string_literal: true

class Api::V1::UserController < Api::V1::AuthenticatedController


=begin
     Create new user
=end
  def create

    begin
      new_user = User.create(params_user_validation)

      if new_user.save
        apitoken = ApiToken.create!(user:new_user)
        apitoken.save

        render json: {user: JSON.parse(new_user.to_json(only:[:name],include: {api_tokens: {only:[:token]}}))},status: :created
      else
        render json: {errors:new_user.errors}, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing => e
      render json: {error: "Missing required parameter #{e.param}"}, status: :unprocessable_entity
    end
  end



=begin
Method to validate if token is correct
=end
  def is_valid_token
    render json: {}, status: :ok
  end


  private

=begin
   Validating given json, to see if all the fields are present and in correct format
=end
  def params_user_validation
    params.require(:user).permit(:name)
    end



end