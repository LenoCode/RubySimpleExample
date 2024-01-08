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
 Adding new role to user
=end
  def add_user_role
    roleId = params["role"]
    user_role = UserRole.find_by(id:roleId)

    if user_role.nil?
      render json: {error: "This role does not exist"}, status: :unprocessable_entity
    else
      if check_if_user_already_has_role user_role
        render json: {"message":"user already has role"}, status: :ok

      else
        create_user_role = XrefUserRole.create user:@current_user, user_role: user_role

        if create_user_role.valid?
          create_user_role.save
          render json: {message: "role added"}, status: :created
        else
          render json: {error: "user role model is not valid"}, status: :unprocessable_entity
        end
      end

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

=begin
   Validating given json, to see if all the fields are present and in correct format
   Role parameter is UserRole model
=end
  def check_if_user_already_has_role(role)
    result = XrefUserRole.joins(:user).joins(:user_role).where("users.name = ?", @current_user.name).where("user_roles.id= ?",role.id)
    !result.empty?

  end

end