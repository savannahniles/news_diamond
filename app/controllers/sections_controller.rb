class SectionsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,     only:  [:new, :create, :edit, :update, :index]


  def show
    @section = Section.find(params[:id])
    @feeds = @section.feeds.paginate(page: params[:page], :per_page => 10)
    @feed = @section.feeds.build if signed_in?
  end#def show

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:success] = "Section created! Cool!"
      redirect_back_or @section
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

  private

    def section_params
      params.require(:section).permit(:name)
    end

end
