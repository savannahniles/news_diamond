class ArticlesController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user,     only: :destroy

	def show
		@article = Article.find(params[:id])
  		@feed = Feed.find(@article.feed_id)
  		@section = Section.find(@feed.section_id)
	end

	def destroy
		feed = Article.find(params[:id]).feed
	    Article.find(params[:id]).destroy
	    flash[:success] = "Article destroyed."
	    redirect_to feed_url(feed)
  	end

end
