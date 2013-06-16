module Api
	module V1
		class UsersController < ApplicationController
			before_filter :restrict_access
			respond_to :json

			def show
					render_success(@user)
			end

			def create
				if @user = User.create(params[:user])
					render_success(@user)
				else
					render_failure()
				end

			end

			private

			def restrict_access

				if @user = User.find_by_auth_token(request.headers['Authorization'])
				else
					render_failure
				end
			end

			def render_success(user)
				render :status => 200,
				:json => { :success => true,
					:info => "Request Success",
					:data => {:user => @user} }
			end

			def render_failure
				render :status => 401,
				:json => { :success => false,
					:info => "Request Failure",
					:data => {} }
			end
			
			
		end
	end
end