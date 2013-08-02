class FeedsController < ApplicationController
  before_action :signed_in_user

  def create
  	@section = Section.find_by_id(params[:section_id])
  	#@feed = @section.feeds.build(feed_params)
  	@feed = Feed.new(feed_params)

  	#@section = Section.find_by_id(params[:section_id])
	#@feed = @section.feeds.build(params[:name, :description])
    if @feed.save
      flash[:success] = "Feed created!"
      redirect_to feed_path(@feed)
    else
      #flash.now[:error] = 'Feed not saved. Did you fill in every field?'
      redirect_to section_path(@section)
      #render :action => "show", :controller => "section", :id => params[:section_id]
    end
  end

  def edit
  end

  def update
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