class RegisteredApplicationsController < ApplicationController

  def index
    @applications = current_user.applications.where(user_id: current_user.id)
  end

  def show
    @application = current_user.applications.find_by(title: params[:id])
    @events_group = @application.events.group_by(&:name)
  end

  def new
    @application = current_user.applications.new
  end

  def create
    @application = current_user.applications.new(application_params)

    if @application.save
      flash[:notice] = "You added an application into your list."
      redirect_to root_path
    else
      flash[:alert] = @applications.errors.full_messages
      render root_path
    end
  end

  def edit
    @application = current_user.applications.find_by(title: params[:id])
  end

  def update
    @application = current_user.applications.find_by(title: params[:id])
    old_title = @application.title
    same_name = current_user.applications.where(title: params[:application][:title])

    if same_name.length > 0 && old_title != params[:application][:title]
      flash[:notice] = "You need to chage your application's name. Someone already use that name."
      redirect_to user_application_path(current_user, application)
    else
      @application.assign_attributes(application_params)
      @application.assign_attributes(slug: params[:title])

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
    application = Application.find_by(title: params[:id])

    if current_user.id != application.user_id
      flash[:alert] = "You can't delete other person's application."
      redirect_to root_path
    else
      if application.destroy
        flash[:notice] = "Your application has been deleted."
        redirect_to root_path
      else
        flash[:alert] = applications.errors.full_messages
      end
    end
  end

  private

  def application_params
    params.require(:application).permit(:title, :url)
  end
end