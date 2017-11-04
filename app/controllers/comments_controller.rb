class CommentsController < ApplicationController

 def create
     @tweet = Tweet.find(params[:tweet_id])
     @comment = @tweet.comments.build(comment_params)
     @comment.user = current_user
 		if @comment.save
 			flash[:success] = "comment was created succesfully"
     	redirect_to tweet_path(@tweet)
    else
 			flash[:danger] = "The comment could not be saved"
 			redirect_to tweet_path(@tweet)
 		end
  end


  def edit
 		@tweet = Tweet.find(params[:tweet_id])
	  @comment = Comment.find(params[:id])
	end


  def update
		@tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			flash[:success] = "Your comment Was Updated Tastefully!"
			redirect_to tweet_path(@tweet)
		else
			render 'edit'
		end
	end


 def destroy
  @tweet = Tweet.find(params[:tweet_id])
  @comment = @tweet.comments.find(params[:id])
  @comment.destroy
  redirect_to tweet_path(@tweet)

 end

 private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def admin_user
    redirect_to tweets_path unless current_user.admin?
  end

  def require_same_user
    if current_user != comment.user and !current_user.admin?
    flash[:danger] = "You can only edit your own tweets"
    redirect_to tweets_path
  end
end
end
