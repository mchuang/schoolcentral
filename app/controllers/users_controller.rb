# @dlaroue

class UsersController < ApplicationController

	before_action :authenticate_user!, :require_login

	@@success_message = "Successfully made changes"

	def show
		@user = current_user
	end

	def update_address
		@user = User.find(current_user.id)
		if @user.update(user_address_params)
			flash[:success] = @@success_message
		else
			#Need to fill flash[:danger] with error messages
		end
		redirect_to '/users/show'
	end

	def update_email
		@user = User.find(current_user.id)
		if @user.update(user_email_params)
			flash[:success] = @@success_message
		else
			#Need to fill flash[:danger] with error messages
		end
		redirect_to '/users/show'
	end

	
	def update_password
		@user = User.find(current_user.id)
		if @user.update_with_password(user_password_params)
			sign_in @user, :bypass => true
			flash[:success] = @@success_message
		else
			flash[:danger] = @user.errors.full_messages.to_sentence
		end
		redirect_to '/users/show'
	end

	def update_phone
		@user = User.find(current_user.id)
		if @user.update(user_phone_params)
			flash[:success] = @@success_message
		else
			#Need to fill flash[:danger] with error messages
		end
		redirect_to '/users/show'
	end


	private

	def user_address_params
	    # NOTE: Using `strong_parameters` gem
	    params.required(:user).permit(:address)
	end

	def user_email_params
	    # NOTE: Using `strong_parameters` gem
	    params.required(:user).permit(:email)
	end

	def user_password_params
	    # NOTE: Using `strong_parameters` gem
	    params.required(:user).permit(:password, :password_confirmation, :current_password)
	end

	def user_phone_params
	    # NOTE: Using `strong_parameters` gem
	    params.required(:user).permit(:phone_mobile)
	end

	def require_login
	    unless user_signed_in?
	      flash[:error] = "please log in"
	      redirect_to new_user_session_path
	    end
	end


end
