class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:commit].eql?('Search')
      if params[:name].blank?
        @courses = Course.where('start_time>=? OR end_time<=?', params[:start_time], params[:end_time]).paginate(:page => params[:page], :per_page => 30)
      else
        @courses = Course.where('name LIKE ? OR start_time>=? OR end_time<=?', "%#{params[:name]}%", params[:start_time], params[:end_time]).paginate(:page => params[:page], :per_page => 30)
      end
    else
      @courses = Course.paginate(:page => params[:page], :per_page => 30)
    end
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
    @course = current_user.courses.new(permit_params)
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
    redirect_to courses_path if course.destroy
  end

  def enrollment
    course = Course.find(params[:id])
    if course.student_count == course.students.count
      render js: "alert('Sorrey this course is full!')" and return
    end
    enroll = current_user.enrollments.new
    enroll.course = course
    if enroll.save
      redirect_to :courses
    else
      render js: "alert('Opps Something went wrong!')"
    end
  end

  private
  def permit_params
    params.require(:course).permit(:name, :description, :category, :subject, :start_time, :end_time, :student_count)
  end
end
