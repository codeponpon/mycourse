class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @course = Course.find_by_id(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find_by_id(params[:id])
  end

  def create
    @course = Course.new(permit_params)
    if @course.save
      redirect_to @course
    else
      render action: :new
    end
  end

  def update
    course = Course.find_by_id(params[:id])
    course.update!(permit_params)
    redirect_to course
  end

  def destroy
    course = Course.find_by_id(params[:id])
    redirect_to course_path if course.destroy
  end

  def search
  end

  private
  def permit_params
    params.require(:course).permit(:name, :description, :category, :subject, :start_time, :end_time)
  end
end
