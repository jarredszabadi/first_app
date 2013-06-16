module Api
	module V1
		class SessionsController < ApplicationController

			before_filter :restrict_access
			respond_to :json

			def create
				if !(@user.auth_token)
					@user.generate_auth_token!()
					render_success(@user)

				else
					render_success(@user)
				end
			end	


			private

			def restrict_access

				if @user = User.find_by_auth_token(request.headers['Authorization'])

				elsif @user = User.find_by_email(params[:user][:email]) 
					if @user && @user.authenticate(params[:user][:password])
					end
				else 
					render_failure
				end
			end

			def render_success(user)
				render :status => 200,
				:json => { :success => true,
					:info => "Login Success",
					:data => {:auth_token => user.auth_token} }
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