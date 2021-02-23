class Student < ApplicationRecord
    has_many :semester
    validates_presence_of :name, :roll_no, :fathers_name, :CGPA, :college_ID, :last_semester, :class_rank
    validates_length_of :roll_no, within: 5..15, on: :create, message: "must be under 15 characters"
    validates_format_of :roll_no, with: /\A[0-9]{4}[a-zA-Z]{4,10}[0-9]{1,4}\z/, on: :create, message: "is Invalid"
    validates_inclusion_of :CGPA, in: 0..10, on: :create, message: " must be between 0 and 10"
    validates_inclusion_of :college_ID, in: 1..100000, on: :create, message: "must be less than 100000"
    validates_inclusion_of :last_semester, in: 1..10, on: :create, message: "must be between 1 and 10"
    validates_uniqueness_of :roll_no, :class_rank
    validates_inclusion_of :class_rank, in:1..1000, message: "must be within 1 and 1000"
end
