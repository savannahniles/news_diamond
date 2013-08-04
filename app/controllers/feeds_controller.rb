class FeedsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,     only:  [:new, :create, :edit, :update]

  def new
    @feed = Feed.new
    @sections = Section.all
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      flash[:success] = "Feed created! Cool!"
      redirect_back_or @feed
    else
      render 'new'
    end
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update_attributes(feed_params)
      flash[:success] = "Feed updated"
      redirect_to @feed
    else
      render 'edit'
    end
  end

  def show
  	@feed = Feed.find(params[:id])
  	@section = Section.find(@feed.section_id)
  end

  private

    def feed_params
      params.require(:feed).permit(:name, :description, :section_id)
    end 

end