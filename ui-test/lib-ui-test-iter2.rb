require_relative 'lib-ui-test'

def createNewAssignment(name, description, max_points, due_date, due_time)
	@@driver.find_element(:tag_name => "button").click

	@@driver.find_element(:id => "name").send_keys name
	@@driver.find_element(:id => "description").send_keys description
	@@driver.find_element(:id => "max_points").send_keys max_points
	@@driver.find_element(:id => "due_date").send_keys due_date
	@@driver.find_element(:id => "due_time").send_keys due_time
	@@driver.find_element(:name => "commit").click
end

def hasCurrentAssignment(name)
	rows = @@driver.find_elements(:class => "assignments-table")[0].find_elements(:tag_name => "tbody")
	rows.each do |row|
		if row.find_elements(:tag_name => "a")[0].text == name
			return true
		end
	end
	return false
end

def hasPastAssignment(name)
	rows = @@driver.find_elements(:class => "assignments-table")[1].find_elements(:tag_name => "tbody")
	rows.each do |row|
		if row.find_elements(:tag_name => "a")[0].text == name
			return true
		end
	end
	return false
end

def changeAttendanceDate(name, date, attendance)
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
		if cells[0].text == name
			cells[1].click
			row.find_elements(:tag_name => "option")[attendance].click
			form.find_element(:name => "commit").click
			break
		end
	end
end

def hasStudent(id)
	students = @@driver.find_element(:id => "students-table").find_element(:tag_name => "tbody").find_elements(:tag_name => "tr")
	students.each do |student|
		if student.find_elements(:tag_name => "td")[2].text == id
			return true
		end
	end
	return false
end