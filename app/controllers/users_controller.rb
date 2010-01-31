class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user,    :only => [:show, :edit, :update, :destroy]
  filter_resource_access
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      #redirect_back_or_default account_url
      redirect_back_or_default user_url(@user)
    else
      render :action => :new
    end
  end
  
  def show
    @user = get_user
  end

  def edit
    @user = get_user
  end
  
  def update
    @user = get_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      #redirect_to account_url
      redirect_to user_url
    else
      render :action => :edit
    end
  end

  def index
    @users = User.find(:all, :order => "login")
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_url
  end

  private
  def get_user
    if params[:id]
      User.find(params[:id])
    else
      @current_user
    end

  end

end
