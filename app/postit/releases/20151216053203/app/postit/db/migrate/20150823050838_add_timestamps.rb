class AddTimestamps < ActiveRecord::Migration
  def change
    add_timestamps :posts
    add_timestamps :comments
    add_timestamps :users
  end
end
