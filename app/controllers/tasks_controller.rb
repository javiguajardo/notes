class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :own_course, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Tasks', :tasks_path

  respond_to :html, :json, :js

  def index
    @tasks = policy_scope(Task).paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def new
    add_breadcrumb 'New', new_task_path
    @task = Task.new
  end

  def edit
    add_breadcrumb 'Edit', edit_task_path
  end

  def create
    @user = current_user
    @task = Task.new(task_params)
    @task.set_task_user(current_user)
    if @task.save
      ReminderMailer.reminder_email(@user, @task).deliver_later
      flash[:notice] = 'Task was successfully created.'
      redirect_to tasks_url
    else
      render 'tasks/new'
    end
  end

  def update
    flash[:notice] = 'Task was successfully updated.' if @task.update(task_params)
    redirect_to tasks_url
  end

  def destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.' if @task.destroy
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :deadline_date, :complete, :user_id, :course_id, :description)
  end

  def own_course
    unless current_user == @task.user
      redirect_to tasks_url, alert: 'You cannot perform an action on this task.'
    end
  end
end
