# frozen_string_literal: true

class Api::V1::UserController < Api::V1::AuthenticatedController


=begin
     Create new user
=end
  def create

    begin
      new_user = User.create(params_user_validation)

      if new_user.save
        render json: {user: new_user},status: :created
      else
        render json: {"errors":new_user.errors}, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing => e
      render json: {"error": "Missing required parameter #{e.param}"}, status: :unprocessable_entity
    end
  end

  private

=begin
   Validating given json, to see if all the fields are present and in correct format
=end
  def params_user_validation
    params.require(:user).permit(:name)
    end



=begin
     List all authorization tokens for specific user
=end
  def get_tokens
    render json: {"tokens": @current_user.api_tokens}
  end


end