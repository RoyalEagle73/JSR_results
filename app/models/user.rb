class User < ApplicationRecord
    has_secure_password
    validates_presence_of :email, :username,:password
    validates_uniqueness_of :email, :username
    validates_format_of :email, with:/\A(\S+)@(.+)\.(\S+)\z/ , on: :create, message: "must be in valid format"
    validates_format_of :username, with: /\A\S+\z/, on: :create, message: "cannot contain whitespaces"
    validates_format_of :password, with: /\A\S+\z/, on: :create, message: "cannot contain whitespaces"
end

