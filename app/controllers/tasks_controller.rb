class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Tasks', :tasks_path

  respond_to :html, :json, :js

  def index
    @tasks = policy_scope(Task).paginate(page: params[:page], per_page: 10).order('id DESC')
    authorize @tasks
  end

  def show
    add_breadcrumb "#{@task.name}", task_path
    authorize @task
  end

  def new
    add_breadcrumb 'New', new_task_path
    @task = Task.new
    authorize @task
  end

  def edit
    add_breadcrumb 'Edit', edit_task_path
    authorize @task
  end

  def create
    @user = current_user
    @task = Task.new(task_params)
    @task.set_task_user(current_user)
    authorize @task
    if @task.save
      ReminderMailer.reminder_email(@user, @task).deliver_later
      flash[:notice] = 'Task was successfully created.'
    end
    respond_with(@task)
  end

  def update
    authorize @task
    flash[:notice] = 'Task was successfully updated.' if @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    authorize @task
    redirect_to tasks_url, notice: 'Task was successfully destroyed.' if @task.destroy
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :deadline_date, :complete, :user_id, :course_id, :description)
  end
end
