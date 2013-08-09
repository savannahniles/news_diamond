class UsersController < ApplicationController
  before_action :signed_in_user,            only: [:index, :edit, :update, :destroy, :today]
  before_filter :signed_in_user_filter,     only: [:new, :create]
  before_action :correct_user,              only: [:edit, :update]
  before_action :admin_user,                only: [:destroy, :index]
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @sections = Section.all
    @feeds = Feed.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the News Diamond! If you have a question, just click the question mark at the top right."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def today
    @title = "Today"
    @user = User.find(params[:id])
    @feeds = @user.feeds
    render 'today'
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user_filter
      if signed_in?
        redirect_to root_path, notice: "Already logged in"
      end
    end
end
