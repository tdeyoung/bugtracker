class Bug < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true
	validates :description, presence: true

	enum issue_type: [:issue, :enhancement, :feature]
	enum priority: [:low, :medium, :high]
	enum status: [:open, :closed, :monitor]
end
