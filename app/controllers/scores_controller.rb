class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]
  protect_from_forgery :unless => :format_json?
  before_action :authenticate_admin_token, :if => :format_json?
  before_action :admin_access_check?, unless: :format_json?
  
  # GET /scores or /scores.json
  def index
    @scores = Score.all
    respond_to do |format|
      format.html
      format.json {render json: @scores, each_serializer: ScoreSerializer}
    end
  end

  # GET /scores/1 or /scores/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: @score, serializer: ScoreSerializer}
    end
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores or /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to @score, notice: "Score was successfully created." }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: "Score was successfully updated." }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: "Score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def score_params
      params.require(:score).permit(:semester_id, :marks, :subject_id, :grade)
    end
end
