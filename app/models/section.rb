class Section < ActiveRecord::Base
	has_many :feeds
	accepts_nested_attributes_for :feeds
	before_save { self.name = name.downcase }

 	validates :name,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
 end
