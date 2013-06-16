module Api
	module V1
		class NotesController < ApplicationController
			before_filter :restrict_access
			respond_to :json

			def index

				render_success(:notes, @user.notes)
				
			end

			def show

				if @user == Note.find(params[:id]).user
					render_success(:note, Note.find(params[:id]))
				else
					render_failure

				end
			end

			def create

				note = @user.create_note!(params[:note][:text])				
				render_success(:note, note)

			end

			private 

			def restrict_access

				if @user = User.find_by_auth_token(request.headers['Authorization'])
				else
					render_failure
				end
			end

			def render_success(data_tag, data)
				render :status => 200,
				:json => { :success => true,
					:info => "Request Success",
					:data => {data_tag => data} }
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