class Note < ActiveRecord::Base
	belongs_to :user, class_name: "User"

	validates :user_id, presence: true
	validates :text, presence: true
end
