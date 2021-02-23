class SemesterSerializer < ActiveModel::Serializer
  attributes :semester_number, :sgpa
  has_many :score
end
