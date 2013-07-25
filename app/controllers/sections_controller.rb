class SectionsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :index]
  before_action :admin_user,     only:  [:new, :create, :edit, :update, :index]


  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:success] = "Section created! Cool!"
      redirect_to @section
    else
      render 'new'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:success] = "Section updated"
      redirect_to @section
    else
      render 'edit'
    end
  end

  def index
  	@sections = Section.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  #before filters

	def signed_in_user
	  unless signed_in?
	    store_location
	    redirect_to signin_url, notice: "Please sign in."
	  end
	end

	def correct_user
	  @user = User.find(params[:id])
	  redirect_to(root_path) unless current_user?(@user)
	end

	def admin_user
	  redirect_to(root_path) unless current_user.admin?
	end

  private

    def section_params
      params.require(:section).permit(:name)
    end

end
