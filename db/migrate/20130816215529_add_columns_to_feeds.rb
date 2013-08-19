class AddColumnsToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :url, :string
    add_column :feeds, :image_src, :string
  end
end
