class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create], :if => :not_subdomain?
  before_filter :require_account_owner, :only => [:new, :create], :if => :subdomain?
  before_filter :require_user, :only => [:show, :edit, :update]


  def index
   @users = current_account.users
  end


  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.account = current_account if current_account
    if @user.save
      flash[:notice] = "User registered!" 
      redirect_back_or_default application_root_url
    else
      render :action => :new
    end
  end
  
  def show
    # use when only account owner allowed to edit his profile
    # if want to allow edit all users, use find(params[:id])
    # @user = @current_user
    @user = User.find(params[:id])
  end

  def edit
    # same case with show
    #@user = @current_user
    @user = User.find(params[:id])
  end
  
  def update
    #@user = @current_user # makes our views "cleaner" and more consistent
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url
    else
      render :action => :edit
    end
  end

  #TODO destroy user function
  #TODO create roles and user_roles table
  #TODO set roles for user

  private 
 
  def not_subdomain?
    not subdomain?  
  end
end
