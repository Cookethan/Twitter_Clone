class AddAvatarToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :avatar, :string
  end
end
