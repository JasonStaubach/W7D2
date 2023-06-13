class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end
    
    def create
        render :new
    end

end