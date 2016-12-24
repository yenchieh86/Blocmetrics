class RegisteredApplicationsController < ApplicationController
    before_action :user_log_in?
    
    def index
        @user = current_user
        @applications = Application.where(user_id: @user.id)
    end
    
    def show
        @application = Application.find_by(title: params[:id])
        @events_group = @application.events.group_by(&:name)
    end
    
    def new
        @user = User.find(params[:user_id])
        @application = current_user.applications.new
    end
    
    def create
        @user = User.find(params[:user_id])
        @application = current_user.applications.new
        @application.slug = params[:application][:title]
        @application.title = params[:application][:title]
        @application.url = params[:application][:url]
        if @application.save
            flash[:notice] = "You added an application into your list."
            redirect_to root_path
        else
            flash[:alert] = @applications.errors.full_messages
            render root_path
        end
    end
    
    def edit
        @user = User.find(params[:user_id])
        @application = Application.find_by(title: params[:id])
    end
    
    def update
        @user = User.find(params[:user_id])
        @application = Application.find_by(title: params[:id])
        old_title = @application.title
        same_name = Application.where(title: params[:application][:title])
        
        if same_name.length > 0 && old_title != params[:application][:title]
            flash[:notice] = "You need to chage your application's name. Someone already use that name."
            redirect_to user_application_path(@user, @application)
        else
            @application.slug = params[:application][:title]
            @application.title = params[:application][:title]
            @application.url = params[:application][:url]
            if @application.save
                flash[:notice] = "Your change has been saved."
                redirect_to root_path
            else
                flash[:alert] = @applications.errors.full_messages
                render root_path
            end
        end
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @application = Application.find_by(title: params[:id])
        if current_user != @user
            flash[:alert] = "You can't delete other person's application."
            redirect_to root_path
        else
            if @application.destroy
                flash[:notice] = "Your application has been deleted."
                redirect_to root_path
            else
                flash[:alert] = @applications.errors.full_messages
            end
        end
    end
    
    private
    
    def user_log_in?
        redirect_to user_session_path unless user_signed_in?
    end
end
