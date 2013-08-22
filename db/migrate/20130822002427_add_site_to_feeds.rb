class AddSiteToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :site, :string
  end
end
