# frozen_string_literal: true

class Api::V1::CatalogController < Api::V1::AuthenticatedController




  def search_books
    author_param= params[:author]
    title_params = params[:title]


    if title_params.nil?
      render json: {result: JSON.parse(Book.all.to_json(only: [:id,:title,:author,:copies]))}, status: ok
    else
      render json: {result: JSON.parse(Book.filter_by_title_and_author(title_params,author_param).to_json(only: [:id,:title, :author, :copies])) }, status: :ok
    end

  end

end
