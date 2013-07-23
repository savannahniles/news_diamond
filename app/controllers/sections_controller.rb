class SectionsController < ApplicationController
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

  private

    def section_params
      params.require(:section).permit(:name)
    end
end
