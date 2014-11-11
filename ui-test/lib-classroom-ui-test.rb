
def toAssignmentsTab
	assignmentsTab =  @@driver.find_element(:id => "assignments-tab") 
	assignmentsTab.click
	@@driver.find_element(:id => "assignments-content") 
	wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	wait.until { @@driver.current_url.downcase != url }
end

def createNewAssignment(name, description, max_points, due_date, due_time)
	@@driver.find_element(:tag_name => "button").click

	@@driver.find_element(:id => "name").send_keys name
	@@driver.find_element(:id => "description").send_keys description
	@@driver.find_element(:id => "max_points").send_keys max_points
	@@driver.find_element(:id => "due_date").send_keys due_date
	@@driver.find_element(:id => "due_time").send_keys due_time
	@@driver.find_element(:name => "commit").click
end

def selectCurrentAssignment(assignmentName)
	assignments = @@driver.find_elements(:class => "assignments-table")[0].find_elements(:tag_name => "tr")
	assignments.each do |assignment|
		info = assignment.find_elements(:tag_name => "a")
		if info[0].text == assignmentName
			return true
		end
	end
	return false
end

def hasCurrentAssignment(assignmentName)
	assignments = @@driver.find_elements(:class => "assignments-table")[0].find_elements(:tag_name => "tr")
	assignments.each do |assignment|
		info = assignment.find_elements(:tag_name => "a")
		if info[0].text == assignmentName
			into[0].click
		end
	end
end

def getCurrentAssignmentDueDate(assignmentName)
	assignments = @@driver.find_elements(:class => "assignments-table")[0].find_elements(:tag_name => "tr")
	assignments.each do |assignment|
		info = assignment.find_elements(:tag_name => "a")
		if info[0].text == assignmentName
			return info[2].text
		end
	end
	return nil
end

def selectPastAssignment(assignmentName)
	assignments = @@driver.find_elements(:class => "assignments-table")[1].find_elements(:tag_name => "tr")
	assignments.each do |assignment|
		info = assignment.find_elements(:tag_name => "a")
		if info[0].text == assignmentName
			info[0].click
		end
	end
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

def getPastAssignmentDueDate(assignmentName)
	assignments = @@driver.find_elements(:class => "assignments-table")[1].find_elements(:tag_name => "tr")
	assignments.each do |assignment|
		info = assignment.find_elements(:tag_name => "a")
		if info[0].text == assignmentName
			return info[2].text
		end
	end
	return nil
end

def toStudentsTab
	studentsTab =  @@driver.find_element(:id => "students-tab") 
	studentsTab.click
	@@driver.find_element(:id => "students-content")
end

def hasStudent(id)
	students = @@driver.find_element(:id => "students-table").find_elements(:tag_name => "tr")
	students.each do |student|
		if student.find_elements(:tag_name => "td")[2].text == id
			return true
		end
	end
	return false
end

def getStudentName(id)
	students = @@driver.find_element(:id => "students-table").find_elements(:tag_name => "tr")
	students.each do |student|
		info = student.find_elements(:tag_name => "td")
		if info[2].text == id
			return info[0] + info[1]
		end
	end
	return nil
end

def getStudentEmail(id)
	students = @@driver.find_element(:id => "students-table").find_elements(:tag_name => "tr")
	students.each do |student|
		info = student.find_elements(:tag_name => "td")
		if info[2].text == id
			return info[3].text 
		end
	end
	return nil
end

def toGradesTab
	gradesTab =  @@driver.find_element(:id => "grades-tab") 
	gradesTab.click
	@@driver.find_element(:id => "grades-content")
end

def getGrade(name, assignment)
	grades = @@driver.find_element(:id => "grades-table").find_elements(:tag_name => "tr")
	grades.each do |grade|
		info = grade
	end
end

def toAttendanceTab
	attendanceTab =  @@driver.find_element(:id => "attendance-tab") 
	attendanceTab.click
	@@driver.find_element(:id => "attendance-content") 
end

def getAttendance(name, date)
	dates = @@driver.find_element(:class => "attendance-table").find_elements(:tag_name => "th")
	dates.each do |date|
		if date.text == date
			date.click
		end
	end
end

def changeAttendance(name, date, attendance)
	dates = @@driver.find_element(:class => "attendance-table").find_elements(:tag_name => "th")
	dates.each do |date|
		if date.text == date
			date.click
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
	end
end