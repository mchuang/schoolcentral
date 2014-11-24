class EventsController < ApplicationController

	def create

		date = nil
		if !params[:due][:date].empty? and !params[:due][:time].empty?
			dateString = params[:due][:date] + " " + params[:due][:time]
			date = DateTime.strptime(dateString, '%Y-%m-%d %H:%M')
		end

		logger.debug "-----------------"
	    logger.debug date

		@event = Event.create(
	        :name => params[:name],
	        :description => params[:description],
	        :startime => date,
	        :endtime => date,
	        :owner => current_user.account
    	)
    	if @event
	    	redirect_to dashboard_index_path
		else
			render json: {message: "fail"}
		end

	end

end
