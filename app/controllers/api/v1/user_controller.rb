# frozen_string_literal: true

class Api::V1::UserController < Api::V1::AuthenticatedController


  def create
    render json: {message: "Authorized"}
  end


end