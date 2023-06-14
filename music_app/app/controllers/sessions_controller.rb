class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:destroy]
    before_action :require_logged_out, only: [:new, :create]

    def new
        render :new
    end

    def create
        email = params[:users][:email]
        password = params[:users][:password]
        @user = User.find_by_credentials(email,password)

        if @user
            login(@user)
            redirect_to user_url(@user.id)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        if logged_in?
            logout!
        end
        flash[:errors] = ['Logged out!'] #using errors for now should make new
        redirect_to new_session_url

    end

end