module AssignmentsHelper

	def formatDate(date)
		return date.strftime("%B %d, %Y at %l:%M %P")
	end

end
