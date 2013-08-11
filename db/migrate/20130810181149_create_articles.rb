class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.string :author
      t.string :summary
      t.string :content
      t.datetime :published
      t.integer :feed_id

      t.timestamps
    end
  end
end
