class Subject < ApplicationRecord
    validates_presence_of :name, :code
    validates_uniqueness_of :code
    validates_format_of :code, with: /\A[a-zA-Z]{1,5}[0-9]{1,10}\z/, on: :create, message: "is invalid"
end
