class User < ApplicationRecord
  has_many :api_tokens

  validate :name_presence


  private

  def name_presence
    errors.add("name","Cant be number, only letters") if name.scan(/\D/).empty?
  end

end
