class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]
  protect_from_forgery :unless => :format_json?
  before_action :authenticate_token, :if => :format_json?
  before_action :normal_access_check?, :unless => :format_json?
  before_action :admin_access_check?, only: %i[ new edit update destroy ]
  
  # GET /students or /students.json
  def index
    @students = Student.all
    respond_to do |format|
      format.html
      format.json {render json: @students, each_serializer: StudentSerializer, include: '**'}
      format.csv {send_data to_csv, filename:"Student_data.csv"}
    end
  end

  # GET /students/1 or /students/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: @student, serializer: StudentSerializer, include: '**'}
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render json :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :roll_no, :fathers_name, :CGPA, :college_ID, :last_semester, :class_rank)
    end

    def to_csv
      CSV.generate(headers:true) do |csv|
        csv << ["Class Rank","Name","Roll no","Fathers name","Cgpa","College id","Last semester"]
        Student.all.each do |student|
          csv<<[student.class_rank.to_s, student.name, student.roll_no, student.fathers_name, student.CGPA.to_s, student.college_ID.to_s ]
        end
      end
    end
end
