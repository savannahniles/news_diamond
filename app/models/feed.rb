class Feed < ActiveRecord::Base
	belongs_to :section
	has_many :relationships, dependent: :destroy
	has_many :reverse_relationships, class_name:  "Relationship", dependent:   :destroy
  	has_many :users, through: :reverse_relationships
  	has_many :articles

	validates :section_id, presence: true
	validates :name, presence: true
	validates :description, presence: true

	def pull_articles(feed_url)
		batch = Feedzirra::Feed.fetch_and_parse(feed_url)
		add_articles(:id, batch.entries)
	end

	private

	def add_articles(feed_id, entries)
		entries.each do |entry|
			if ( articles.none? { |art| art.guid == entry.id} && current?(entry.published) )
				articles.create(title: entry.title, url: entry.url, author: entry.author, summary: entry.summary, content: entry.content, published: entry.published, guid: entry.id)
			end#if
		end#do
	end#def add_entries

	def current?(time) 
		now = Time.now
		last_year = now - (60*60*24*365)
		return time.between?(last_year, now)
	end#current

end
