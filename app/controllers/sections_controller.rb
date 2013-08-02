class SectionsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,     only:  [:new, :create, :edit, :update, :index]


  def show
    @section = Section.find(params[:id])
    @feeds = @section.feeds.paginate(page: params[:page], :per_page => 10)
    @feeds_all = @section.feeds
    #@feeds_even = []
    #@feeds_odd = []

    #index=0
    #@feeds_all.each do |feed|
      #if feed.id%2 == 0
        #@feeds_even.push(feed)
      #elsif feed.id%2 != 0
        #@feeds_odd.push(feed)
      #end#if else
    #end#feeds do

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
