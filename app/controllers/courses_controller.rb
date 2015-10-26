class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Courses', :courses_path

  respond_to :html, :json, :js

  def index
    @courses = policy_scope(Course).paginate(page: params[:page], per_page: 10).order('id DESC')
    authorize @courses
  end

  def show
    add_breadcrumb "#{@course.name}", course_path
    authorize @course
  end

  def new
    add_breadcrumb 'New', new_course_path
    @course = Course.new
    authorize @course
  end

  def edit
    add_breadcrumb 'Edit', edit_course_path
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    @course.set_course_user(current_user)
    authorize @course
    flash[:notice] = 'Notebook was successfully created.' if @course.save
    respond_with(@course)
  end

  def update
    authorize @course
    flash[:notice] = 'Course was successfully updated.' if @course.update(course_params)
    respond_with(@course)
  end

  def destroy
    authorize @course
    if @course.destroy
      redirect_to courses_url, notice: 'Course was successfully destroyed.'
    else
      redirect_to :back, alert: "The course #{@course.name} has tasks."
    end
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name)
  end
end
 
