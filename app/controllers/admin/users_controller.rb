class Admin::UsersController < ApplicationController
  before_action :admin_check

  def index
    @users = User.all.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(user_params)

    if @admin.save
      session[:user_id] = @admin.id # auto log in
      redirect_to movies_path, notice: "Welcome aboard, #{@admin.firstname}!"
    else
      render :new
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.welcome_email(@user).deliver
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
