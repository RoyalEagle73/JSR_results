class StudentSerializer < ActiveModel::Serializer
  attributes :class_rank, :roll_no, :name, :fathers_name, :CGPA, :last_semester, :grade_url
  has_many :semester

  def grade_url
    "http://117.252.249.5/StudentPortal/commanreport.aspx?pagetitle=gradecarde&path=crptNewGradecard.rpt&param=@P_IDNO="+object.college_ID.to_s+",@P_SEMESTERNO="+object.last_semester.to_s+",@P_COLLEGE_CODE=11"
  end

end
