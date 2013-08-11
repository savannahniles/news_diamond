class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @feed = Feed.find(params[:relationship][:feed_id])
    current_user.follow!(@feed)
    respond_to do |format|
      format.html { redirect_to @feed }
      format.js
    end
  end

  def destroy
    @feed = Relationship.find(params[:id]).feed
    current_user.unfollow!(@feed)
    respond_to do |format|
      format.html { redirect_to @feed }
      format.js
    end
  end
end