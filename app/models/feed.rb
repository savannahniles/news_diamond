class Feed < ActiveRecord::Base
	belongs_to :section
	has_many :relationships, dependent: :destroy
	has_many :reverse_relationships, class_name:  "Relationship", dependent:   :destroy
  	has_many :users, through: :reverse_relationships
  	has_many :articles

	validates :section_id, presence: true
	validates :name, presence: true
	validates :description, presence: true
	validates :url, presence: true
	validates :site, presence: true
	validates :image_src, presence: true

	def self.update_all_feeds
	  find(:all).each do |feed|
	    feed.pull_articles
	  end
	end

	def self.update_feeds(feeds)
		feeds.each do |feed|
			feed.pull_articles
		end
	end

	def pull_articles
		batch = Feedzirra::Feed.fetch_and_parse(self.url)
		add_articles(:id, batch.entries)
		self.articles = self.articles.slice!(0, 50)
		self.updated_at = Time.now
	end

	private

	def add_articles(feed_id, entries)   #clean this up
		entries.each do |entry|
			author = "" unless entry.author
			if entry.author
				author = entry.author
			else
				author = ""
			end

			if entry.summary
				summary = entry.summary
			else
				summary = ""
			end

			if entry.content
				content = entry.content
			else
				content = ""
			end

			if ( articles.none? { |art| art.guid == entry.id} && current?(entry.published) )
				articles.create(title: entry.title, url: entry.url, author: author, summary: summary, content: content, published: entry.published, guid: entry.id)
			end#if
		end#do
	end#def add_entries

	def current?(time) 
		now = Time.now
		last_year = now - (60*60*24*365)
		return time.between?(last_year, now)
	end#current



end
