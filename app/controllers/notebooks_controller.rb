class NotebooksController < ApplicationController
  before_action :set_notebook, only: [:show, :edit, :update, :destroy]
  before_action :own_notebook, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Notebooks', :notebooks_path

  respond_to :html, :json, :js

  def index
    @notebooks = policy_scope(Notebook).paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def show
    add_breadcrumb "#{@notebook.name}", notebook_path
    @notes = Note.where(id: Notebook.find(params[:id]).notes).
        paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def new
    add_breadcrumb 'New', new_notebook_path
    @notebook = Notebook.new
  end

  def edit
    add_breadcrumb 'Edit', edit_notebook_path
  end

  def create
    @notebook = Notebook.new(notebook_params)
    @notebook.set_notebook_user(current_user)
    flash[:notice] = 'Notebook was successfully created.' if @notebook.save
    respond_with(@notebook)
  end

  def update
    flash[:notice] = 'Notebook was successfully updated.' if @notebook.update(notebook_params)
    respond_with(@notebook)
  end

  def destroy
    if @notebook.destroy
      redirect_to notebooks_url, notice: 'Notebook was successfully destroyed.'
    else
      redirect_to :back, alert: "The notebook #{@notebook.name} has notes."
    end
  end

  private
  def set_notebook
    @notebook = Notebook.find(params[:id])
  end

  def notebook_params
    params.require(:notebook).permit(:name, :user_id, :course_id)
  end

  def own_notebook
    unless current_user == @notebook.user || current_user.role.key = 'admin'
      redirect_to notebooks_url, alert: 'You cannot perform an action on this notebook.'
    end
  end
end