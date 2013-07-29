class Feed < ActiveRecord::Base
	belongs_to :section
	validates :section_id, presence: true
	validates :name, presence: true
	validates :description, presence: true
end
