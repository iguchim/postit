class AddPrimaryKeyToCategoryPostTable < ActiveRecord::Migration
  def change
    add_column :category_posts, :id, :primary_key
  end
end
