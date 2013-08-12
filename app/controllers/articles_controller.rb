class ArticlesController < ApplicationController
	before_action :signed_in_user

	def show
		@article = Article.find(params[:id])
  		@feed = Feed.find(@article.feed_id)
  		@section = Section.find(@feed.section_id)
	end

end
