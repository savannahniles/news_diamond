class StaticPagesController < ApplicationController
  def home
    @sections = Section.all
  end

  def help
  end

  def about
  end

  def contact
  end

  def privacy_policy
  end
end
