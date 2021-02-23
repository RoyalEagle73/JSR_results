class UserSerializer < ActiveModel::Serializer
  attributes :username, :api_token, :email
end
