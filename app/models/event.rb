class Event < ActiveRecord::Base
  	belongs_to :owner, :polymorphic => true
  	belongs_to :classroom

  	def self.get_dates_for_month(year, month)
		firstDate = Date.new(year, month, 1)
		if !firstDate.sunday?
			firstDate = firstDate.beginning_of_week - 1
		end
		lastDate = Date.new(year, month, -1)
		if lastDate.sunday?
			lastDate = lastDate + 6
		elsif !lastDate.saturday?
			lastDate = lastDate.end_of_week - 1
		end

		dateArr = (firstDate..lastDate).to_a

		dateHashArr = []
		i = 0

		while i < dateArr.length
			weekArr = []
			for j in (0..6)
				date = dateArr[i+j]
				weekArr.push({date: date.day, month: date.month})
			end
			dateHashArr.push(weekArr)
			i += 7
		end

		return dateHashArr

		# i = 0
		# weekArr = []
		# while i < dateArr.length
		# 	weekArr.push(dateArr.slice(i, 7))
		# 	i += 7
		# end
		# return weekArr
	end

	def self.get_events_for_month(year, month)

	end
end
