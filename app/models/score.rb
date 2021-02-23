class Score < ApplicationRecord
  belongs_to :semester
  belongs_to :subject
  validates_presence_of :semester_id, :marks, :subject_id
  validates_inclusion_of :marks, in: 1..100, on: :create, message: "Marks must be less than or equal to 100"
end
