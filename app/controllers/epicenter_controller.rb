class EpicenterController < ApplicationController
  def feed
    @tweet = Tweet.new
    @following_tweets = []

    Tweet.all.each do |tweet|
        if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
          @following_tweets.push(tweet)
        end
    end
    @following_tweets = @following_tweets.sort_by(&:created_at)
    @following_tweets.reverse!
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save
  
    redirect_to show_user_path(id: params[:id])  	
  end

  def create_tweet
    tweet = Tweet.create(tweet_params)
    redirect_to root_path
  end

  def tweets
    @tweet = Tweet.all
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  private 

  def tweet_params
    params.require(:tweet).permit(:message, :user_id)
  end
end
