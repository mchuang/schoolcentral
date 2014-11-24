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
	        :ownder_id => params[:owner_id]
    	)
    	if @event
    		logger.debug "-----------------"
	    	logger.debug @event
			logger.debug "-------------" + current_user.account.events.length.to_s
    		current_user.account.events.append(@event)
			logger.debug "-------------" + current_user.account.events.length.to_s
	    	redirect_to dashboard_index_path
		else
			render json: {message: "fail"}
		end

	end

end
