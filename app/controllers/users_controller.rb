class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :redirect_incorrect_users, only: [:edit, :update, :destroy]

  def index
    @users = User.registered
  end
  
  def authors
    @authors = User.authors
  end

  def show
    @recent_posts = Post.where(user_id: current_user.id).limit(5)
    @recent_comments = Comment.where(user_id: current_user.id).limit(5)
    @messages = Message.where(recipient_id: current_user.id).where(viewed: false)
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
    params.require(:user).permit(:email,:name,:phone_number,:avatar,:password,:password_confirmation,:description)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def redirect_incorrect_users
    if @user != current_user
      redirect_to current_user
    end
  end
end
