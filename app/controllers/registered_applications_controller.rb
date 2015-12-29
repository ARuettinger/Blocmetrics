class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def new
  	@registered_application = RegisteredApplication.new
  end

  def create
  	@registered_application = RegisteredApplication.new(registered_application_params)
  	@registered_application.user = current_user

  	if @registered_application.save
  		flash[:notice] = "Registered Application was saved successfully."
  		redirect_to @registered_application
  	else
  		flash[:error] = "Registered Application failed to save."
  		render :new
  	end
  end

  def index
  	@registered_applications = current_user.registered_applications.all
  end

  def edit
  	@registered_application = RegisteredApplication.find(params[:id])
  end

  def update
  	@registered_application = RegisteredApplication.find(params[:id])

  	@registered_application.assign_attributes(registered_application_params)

  	if @registered_application.save
  		flash[:notice] = "Registered Application was updated."
  		redirect_to @registered_application
  	else
  		flash[:error] = "Error saving Registered Application. Please try again."
  		render :edit
  	end
  end

  def show
  	@registered_application = RegisteredApplication.find(params[:id])

  	@events = @registered_application.events.group_by(&:name)
  end

  def destroy
  	@registered_application = RegisteredApplication.find(params[:id])

  	if @registered_application.destroy
  		flash[:notice] = "\"#{@registered_application.name}\" was deleted successfully."
  		redirect_to action: :index
  	else
  		flash[:error] = "there was an error deleting your Registered Application."
  		render :show
  	end
  end

  private
  def registered_application_params
  	params.require(:registered_application).permit(:name, :url)
  end
end
