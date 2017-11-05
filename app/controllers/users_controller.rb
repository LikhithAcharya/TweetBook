class UsersController < ApplicationController

  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]



  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

   def my_friends
     @friendships = current_user.friends

   end

   def search
    @users = User.search(params[:search_params])

    if @users
      @users = current_user.except_current_user(@users)
      render partial: "friends/lookup"
    else
      render status: :not_found, nothing: true
    end
   end

 def add_friend
  @friend = User.find(params[:friend])
  current_user.friendships.build(friend_id: @friend.id)

  if current_user.save
    redirect_to my_friends_path, notice: "Friend was successfully added"
  else
    redirect_to my_friends_path, flash[:error] = "There was an error adding user as friend"
  end
 end

def new
    @user = User.new
end

def show
  @user = User.find(params[:id])
  @user_tweets = @user.tweets
end

def create
      @user = User.new(user_params)
       if @user.save
         session[:user_id] = @user.id
          flash[:success] = "Welcome to tweet book #{@user.username}"
          redirect_to user_path(@user)
      else
        render 'new'
      end

end

    def edit
      @user = User.find(params[:id])
    end

def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Your account was updated successfully"
        redirect_to tweets_path
      else
        render 'edit'
      end
end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and all articles created by user have been deleted"
        redirect_to users_path
    end

private

    def user_params
    params.require(:user).permit(:username, :email, :password)
   end

   def require_same_user
        if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
        end
    end

    def require_admin
      if logged_in? and !current_user.admin?
          flash[:danger] = "Only admin users can perform that action"
          redirect_to root_path
      end
   end

end
