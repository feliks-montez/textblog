class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by(uuid: current_user.uuid)
    
    if @user.update(user_params)
      sign_in @user
      flash[:success] = "Your profile has been created successfully."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated successfully."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email,:fname,:lname,:phone_number,:avatar,:password,:password_confirmation,:description)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
