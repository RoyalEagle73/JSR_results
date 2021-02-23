class Semester < ApplicationRecord
  belongs_to :student
  has_many :score
  validates_presence_of :semester_number, :student_id, :sgpa
  validates_inclusion_of :sgpa, in:1..10 , on: :create, message: "must be in range of 1 to 10"
  validates_inclusion_of :semester_number, in:1..10 , on: :create, message: "must be in range of 1 to 10"
end
