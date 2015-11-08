class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Courses', :courses_path

  respond_to :html, :json, :js

  def index
    @courses = policy_scope(Course).paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def show
    add_breadcrumb "#{@course.name}", course_path
    @tasks = Task.where(id: Course.find(params[:id]).tasks).
        paginate(page: params[:page], per_page: 10).order('id DESC')
    @notebooks = Notebook.where(id: Course.find(params[:id]).notebooks).
        paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def new
    add_breadcrumb 'New', new_course_path
    @course = Course.new
  end

  def edit
    add_breadcrumb 'Edit', edit_course_path
  end

  def create
    @course = Course.new(course_params)
    @course.set_course_user(current_user)
    flash[:notice] = 'Course was successfully created.' if @course.save
    respond_with(@course)
  end

  def update
    flash[:notice] = 'Course was successfully updated.' if @course.update(course_params)
    respond_with(@course)
  end

  def destroy
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
    params.require(:course).permit(:name, :user_id)
  end
end

