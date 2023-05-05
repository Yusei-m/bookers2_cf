class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user.id)
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] ="You have updated user successfully."
  else
    render :edit
  end
   
  end
  
  def index
    @users = User.all
     @book = Book.new
  end
  
  def new
    @book = Book.new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
