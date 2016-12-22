class RegisteredApplicationsController < ApplicationController
    before_action :user_log_in?
    
    def index
        @user = current_user
        @applications = Application.where(user_id: @user.id)
    end
    
    def show
        find_target
    end
    
    def new
        new_app_init
    end
    
    def create
        app = Application.where(title: params[:application][:title])
        if app.length > 0
            flash[:notice] = "You need to chage your application's name. Someone already use that name."
            redirect_to root_path
        else
            new_app_init
            set_parameters
            if @application.save
                flash[:notice] = "You added an application into your list."
                redirect_to root_path
            else
                flash[:alert] = @applications.errors.full_messages
                render root_path
            end
        end
    end
    
    def edit
       find_target
    end
    
    def update
        find_target
        old_title = @application.title
        same_name = Application.where(title: params[:application][:title])
        
        if same_name.length > 0 && old_title != params[:application][:title]
            flash[:notice] = "You need to chage your application's name. Someone already use that name."
            redirect_to user_application_path(@user, @application)
        else
            set_parameters
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
        find_target
        if current_user != @user
            flash[:alert] = "You can't delete other person's application."
            render root_path
        else
            if @application.destroy
                flash[:notice] = "Your application has been deleted."
                redirect_to root_path
            end
        end
    end
    
    private
    
    def user_log_in?
        redirect_to user_session_path unless user_signed_in?
    end
    
    def new_app_init
        @user = User.find(params[:user_id])
        @application = @user.applications.new
    end
    
    def find_target
        @user = User.find(params[:user_id])
        @application = Application.find_by(title: params[:id])
    end
    
    def set_parameters
        @application.slug = params[:application][:title]
        @application.title = params[:application][:title]
        @application.url = '/users/' + params[:user_id] + '/registered_applications/' + params[:application][:title]
    end
end
