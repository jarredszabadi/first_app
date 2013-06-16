class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to root_url, notice: "Signed Up!"
		else
			render "new"
		end
	end

	def show
		@title = "Profile"
		@user = User.find(params[:id])
	end

	def update
	end

	
end
