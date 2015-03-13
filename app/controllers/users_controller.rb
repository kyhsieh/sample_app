class UsersController < ApplicationController
  def new   # for GET, /users, user_path
    @user = User.new
  end

  def show   # for GET, /users/x, user_path(user)
    #debugger
    @user = User.find(params[:id]);
  end

  def create   # for POST, /users, users_path
    @user = User.new(user_params)   # use the user_params func to permit only the attribute needed and allowed, instead of whole User
    if @user.save
      flash[:success] = "#{@user.name}, welcome to the Sample App!"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
