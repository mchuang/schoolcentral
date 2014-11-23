
def selectClassroom(classroom)
	classroomTab =  @@driver.find_element(:id => classroom) 
	classroomTab.click
end

def hasCalendar
	if @@driver.find_element(:id => "calendar")
		return true
	else
		return false
	end
end

def clickNextMonth
	buttons = @@driver.find_element(:class => "calendar-navigation").find_elements(:class => "button")
	buttons[2].click
end

def clickPrevMonth
	buttons = @@driver.find_element(:class => "calendar-navigation").find_elements(:class => "button")
	buttons[0].click
end

def clickToday
	buttons = @@driver.find_element(:class => "calendar-navigation").find_elements(:class => "button")
	buttons[1].click
end

def getMonth
	month = @@driver.find_element(:class => "month-label").text
	return month
end

def getActiveDate
	date = @@driver.find_element(:id => "calendar").find_element(:class => "active")
	return date.attribute(id)
end

def getCalendarEvents(date)
	date = @@driver.find_element(:id => date)
	return date.find_elements(:class => "events")
end

def hasDayInfoFeed
	if @@driver.find_element(:id => "day-info-feed-panel")
		return true
	else
		return false
	end
end

def hasDayInfoFeedEvent(event)
	links = @@driver.find_element(:id => "day-info-feed-panel").find_elements(:tag_name => "a")
	links.each do |link|
		if link.text == event
			return true
		end
	end
	return false
end

def clickDayInfoFeedEvent(event)
	links = @@driver.find_element(:id => "day-info-feed-panel").find_elements(:tag_name => "a")
	links.each do |link|
		if link.text == event
			link.click
		end
	end
end

def toProfile
	profileBtn =  @@driver.find_element(:id => "profile-path") 
	profileBtn.click
	@@driver.find_element(:class => "user-profile") 
end

def clickProfDisplay
	profileBtn =  @@driver.find_element(:class => "user-image") 
	profileBtn.click
	@@driver.find_element(:class => "user-profile") 
end