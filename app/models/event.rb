class Event < ActiveRecord::Base
  	belongs_to :owner, :polymorphic => true
  	belongs_to :classroom

  	def self.calendar_first_date(year, month)
  		firstDate = Date.new(year, month, 1)
		if !firstDate.sunday?
			firstDate = firstDate.beginning_of_week - 1
		end
		return firstDate
	end

	def self.calendar_last_date(year, month)
		lastDate = Date.new(year, month, -1)
		if lastDate.sunday?
			lastDate = lastDate + 6
		elsif !lastDate.saturday?
			lastDate = lastDate.end_of_week - 1
		end
		return lastDate
	end

  	def self.get_dates_for_month(year, month)
		firstDate = calendar_first_date(year, month)
		lastDate = calendar_last_date(year, month)

		dateArr = (firstDate..lastDate).to_a
		i = 0
		weekArr = []
		while i < dateArr.length
			weekArr.push(dateArr.slice(i, 7))
			i += 7
		end
		return weekArr
	end

    def self.get_date_range(account, start_d, end_d)
        account.events.where(
            '(startime BETWEEN :st AND :ed) OR (endtime BETWEEN :st AND :ed)',
            { st: start_d, ed: end_d }
        ).order('startime')
    end

    def self.get_day(account, date)
        get_date_range(account, date.beginning_of_day, date.end_of_day)
    end

    def self.get_week(account, date)
        get_date_range(account, date.beginning_of_week, date.end_of_week)
    end

    def self.get_month(account, date)
        get_date_range(account, date.beginning_of_month, date.end_of_month)
    end
end
