# voe

class DashboardController < ApplicationController

	def index
		@classrooms = current_user.account.classrooms

		render 'dashboard'
	end

end
