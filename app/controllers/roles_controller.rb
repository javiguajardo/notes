class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Roles', :roles_path

  respond_to :html, :json, :js

  def index
    @roles = Role.paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def show
    add_breadcrumb "#{@role.name}", role_path
  end

  def new
    add_breadcrumb 'New', new_role_path
    @role = Role.new
  end

  def edit
    add_breadcrumb 'Edit', edit_role_path
  end

  def create
    @role = Role.new(role_params)
    flash[:notice] = 'Role was successfully created.' if @role.save
    respond_with(@role)
  end

  def update
    flash[:notice] = 'Role was successfully updated.' if @role.update(role_params)
    respond_with(@role)
  end

  def destroy
    if @role.destroy
      redirect_to roles_url, notice: 'Role was successfully destroyed.'
    else
      redirect_to :back, alert: "The role #{@role.name} has users."
    end
  end

  private
  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :key, :description)
  end
end
 
