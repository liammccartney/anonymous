class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to posts_path
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    if current_user
    @votes = current_user.votes
    else
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end
