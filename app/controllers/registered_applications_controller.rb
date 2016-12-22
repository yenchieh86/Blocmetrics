class RegisteredApplicationsController < ApplicationController
    before_action :user_log_in?
    
    def index
        @user = current_user
        @applications = Application.where(user_id: @user.id)
    end
    
    def show
        @user = current_user
        @application = Application.find(params[:id])
    end
    
    def new
        @user = User.find(params[:user_id])
        @application = @user.applications.new
    end
    
    def create
        @user = User.find(params[:user_id])
        @application = @user.applications.new()
        @application.title = params[:application][:title]
        @application.url = '/user/' + params[:user_id] + '/registered_applications/' + params[:application][:title]
       
        if @application.save
            flash[:notice] = "You added an application into your list"
            redirect_to root_path
        else
            flash[:alert] = @applications.errors.full_messages
            render root_path
        end
    end
    
    private
    
    def user_log_in?
        redirect_to user_session_path unless user_signed_in?
    end
end
