class UsersController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:show]
    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find(params[:id])
        render :show
    end
    
    def create
        @user = User.new(user_params)

        if @user
            @user.save
            login(@user)
            redirect_to user_url(@user.id)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def user_params
        params.require(:users).permit(:email, :password)
    end
end