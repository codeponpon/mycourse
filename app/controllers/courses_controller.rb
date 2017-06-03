class CoursesController < ApplicationController
  def index
    @courses = Course.paginate(:page => params[:page], :per_page => 30)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
