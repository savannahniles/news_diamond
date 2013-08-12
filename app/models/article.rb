class Article < ActiveRecord::Base
	belongs_to :feed
	default_scope -> { order('published DESC') }
	validates :feed_id, presence: true
end
