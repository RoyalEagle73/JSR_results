class ScoreSerializer < ActiveModel::Serializer
  has_one :subject
  attributes :marks, :grade
end
