require_relative 'lib-basic-ui-test'

def getAttendance(name, date)
	dates = @@driver.find_element(:tag_name => "thead").find_elements(:tag_name => "th")
	dates.each do |date|
		if date.text == date
			date.click
		end
	end

	form = @@driver.find_element(:id => "attendanceInputModal").find_element(:tag_name => "table")
	rows = form.find_elements(:tag_name => "tr")
	rows.each do |row|
		cells = row.find_elements(:tag_name => "td")
		if cells[0].find_element(:tag_name => "label").text == name
			cells[1].click
			row.find_elements(:tag_name => "option")[attendance].click
			form.find_element(:name => "commit").click
			break
		end
	end
end

def changeAttendance(name, date, attendance)
	dates = @@driver.find_element(:tag_name => "thead").find_elements(:tag_name => "th")
	dates.each do |date|
		if date.text == date
			date.click
		end
	end

	form = @@driver.find_element(:id => "attendanceInputModal").find_element(:tag_name => "table")
	rows = form.find_elements(:tag_name => "tr")
	rows.each do |row|
		cells = row.find_elements(:tag_name => "td")
		if cells[0].find_element(:tag_name => "label").text == name
			cells[1].click
			row.find_elements(:tag_name => "option")[attendance].click
			form.find_element(:name => "commit").click
			break
		end
	end
end