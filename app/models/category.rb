class Category < ActiveRecord::Base
	has_many :quotes

	validates :name, presence: true, uniqueness: true
end