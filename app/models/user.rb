class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :auth_token


	has_many :notes

	
	has_secure_password
	validates :password, :length => {:within =>6..40}, :on => :create
	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
	validates_presence_of :email
	validates_uniqueness_of :email

	def create_note!(text)
		self.notes.create!(text: text)
	end

	def generate_auth_token!()
		puts"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		begin
			self.auth_token = SecureRandom.urlsafe_base64

		end while User.exists?(:auth_token => self.auth_token)
		self.save!
		
	end
end
