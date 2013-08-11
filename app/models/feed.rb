class Feed < ActiveRecord::Base
	belongs_to :section
	has_many :relationships, dependent: :destroy
	has_many :reverse_relationships, class_name:  "Relationship", dependent:   :destroy
  	has_many :users, through: :reverse_relationships
  	has_many :articles

	validates :section_id, presence: true
	validates :name, presence: true
	validates :description, presence: true
end
