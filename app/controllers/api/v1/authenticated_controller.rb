# frozen_string_literal: true

class Api::V1::AuthenticatedController < ActionController::Base

  before_action :authenticate

  attr_reader :current_api_token, :current_user


=begin
  Interceptor that will be called before any action method
=end
  def authenticate
    authenticate_user_with_token || handle_bad_authentication
  end



=begin
  Main function for checking if token exists.If token exists then
  user_controller is allowed to access resources, if not it will return false
 and call handle_bad_authentication
=end
  def authenticate_user_with_token
    if params["controller"].to_s == 'api/v1/user' and params['action'].to_s == 'create'
      true
    else
      authenticate_with_http_token do |token,options|
        @current_api_token = ApiToken.where(active: true).find_by(token:token)
        @current_user = @current_api_token&.user
      end
    end
  end


=begin
   Handle bad authentication, creates json and return it back to user_controller
=end
  def handle_bad_authentication
    render json: {message: "Bad credentials"}, status: :unauthorized
  end

end
