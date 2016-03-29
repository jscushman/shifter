class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user, only: [:index, :show, :edit, :update]
  before_action :authenticate_admin, only: [:index]
  
  def index
    @users = User.all
  end
  
  def show
    authenticate_specific_user @user
  end

  def new
    @user = User.new 
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, flash: { success: 'User was successfully created.' }
    else
      render :new
    end
  end
  
  def edit
    authenticate_specific_user @user
  end
  
  def update
    authenticate_specific_user @user
    if @user.update(user_params)
      redirect_to @user, flash: { success: 'User was successfully updated.' }
    else
      render :edit
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if admin?
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
      else
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
    end
end