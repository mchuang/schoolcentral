class UsersController < ApplicationController

	before_action :authenticate_user!

	def show
		@person = current_user.account
	end
end
