class UsersController < ApplicationController
  respond_to :html, :json, :js

  def edit
    @user = current_user
    add_breadcrumb 'Edit Profile', edit_user_path
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params) && @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, bypass: true
      redirect_to authenticated_root_path, notice: 'The password was updated succesfully'
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to home_index_url, notice: 'User was successfully destroyed.' if @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :current_password, :password, :password_confirmation)
  end
end
