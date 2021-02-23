json.extract! user, :id, :username, :password_digest, :api_token, :is_admin, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
