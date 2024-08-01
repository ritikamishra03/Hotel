class UsersController < ApplicationController
    before_action :authorize_admin,only: [:edit,:update]
    # before_action :authorize_user, only[:new, :create]
  
    def index
      @users = User.all
    end

    def show
      @user=User.find(params[:id])
    end 
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      # debugger  
      @user=User.find(params[:id])
      @user.destroy
      redirect_to users_path, notice: 'Booking was successfully destroyed.'
  end
  
    private
  
    def user_params
      params.require(:user).permit(:role)
    end

  end
  
    
