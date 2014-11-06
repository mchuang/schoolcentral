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
		i = 0
		weekArr = []
		while i < dateArr.length
			weekArr.push(dateArr.slice(i, 7))
			i += 7
		end
		return weekArr
	end
end
