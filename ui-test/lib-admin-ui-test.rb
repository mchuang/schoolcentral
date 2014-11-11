require_relative 'lib-basic-ui-test'

def hasStudent(id)
	students = @@driver.find_element(:id => "tableData").find_element(:tag_name => "tbody").find_elements(:tag_name => "tr")
	students.each do |student|
		if student.find_elements(:tag_name => "td")[1].text == id
			return true
		end
	end
	return false
end

def hasTeacher(id)
	teachers = @@driver.find_element(:id => "tableData").find_element(:tag_name => "tbody").find_elements(:tag_name => "tr")
	teachers.each do |teacher|
		if teacher.find_elements(:tag_name => "td")[1].text == id
			return true
		end
	end
	return false
end

def hasClassroom(course)
	classrooms = @@driver.find_element(:id => "tableData").find_element(:tag_name => "tbody").find_elements(:tag_name => "tr")
	classrooms.each do |classroom|
		if classroom.find_elements(:tag_name => "td")[0].text == course
			return true
		end
	end
	return false
end

def toClassroomsAdminTab
	url = @@driver.current_url.downcase 
	classroomsTab =  @@driver.find_element(:id => "classrooms-tab") 
	classroomsTab.click
	@@driver.find_element(:id => "tableData") 
	wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	wait.until { @@driver.current_url.downcase != url }
end

def toStudentsAdminTab
	url = @@driver.current_url.downcase 
	studentsTab =  @@driver.find_element(:id => "students-tab") 
	studentsTab.click
	@@driver.find_element(:id => "tableData") 
	wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	wait.until { @@driver.current_url.downcase != url }
end

def toTeachersAdminTab
	url = @@driver.current_url.downcase 
	teachersTab =  @@driver.find_element(:id => "teachers-tab")
	teachersTab.click
	@@driver.find_element(:id => "tableData") 
	wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	wait.until { @@driver.current_url.downcase != url }
end

def createClassroom(teacher, students, course, time, description, capacity)
	navigateToClassroomsAdminTab()
	newLink =  @@driver.find_element(:id => "new-link") 
	newLink.click
	@@driver.find_element(:class => "new-form") 
	@@driver.find_element(:id => "teacher").send_keys teacher
	@@driver.find_element(:id => "students").send_keys students
	@@driver.find_element(:id => "name").send_keys course
	@@driver.find_element(:id => "time").send_keys time
	@@driver.find_element(:id => "description").send_keys description
	@@driver.find_element(:id => "capacity").send_keys capacity
	@@driver.find_element(:name => "commit").click
end

def classroomCreated?(teachers, students, course, time, description, capacity)
end 

def editClassroom(classroom, teachers, students, course, time, description, capacity)
	navigateToClassroomsAdminTab()
	infoLink =  @@driver.find_element(:id => classroom) 
	infoLink.click
	@@driver.find_element(:class => "class-info") 
	teachElement = @@driver.find_element(:id => "teachers")
	teachElement.clear
	teachElement.send_keys teachers
	studElement = @@driver.find_element(:id => "students")
	studElement.clear
	studElement.send_keys students
	courseElement = @@driver.find_element(:id => "course")
	courseElement.clear
	courseElement.send_keys students
	timeElement = @@driver.find_element(:id => "time")
	timeElement.clear
	timeElement.send_keys students
	descElement = @@driver.find_element(:id => "description")
	descElement.clear
	descElement.send_keys description
	capElement = @@driver.find_element(:id => "capacity")
	capElement.clear
	capElement.send_keys students
	@@driver.find_element(:name => "commit").click
end

def createTeacher(firstname, middlename, lastname, id)
	navigateToTeachersAdminTab()
	newLink =  @@driver.find_element(:id => "new-link") 
	newLink.click
	@@driver.find_element(:class => "new-form") 
	@@driver.find_element(:id => "firstname").send_keys firstname
	@@driver.find_element(:id => "middlename").send_keys middlename
	@@driver.find_element(:id => "lastname").send_keys lastname
	@@driver.find_element(:id => "id").send_keys id
	@@driver.find_element(:name => "commit").click
end

def createStudent(firstname, middlename, lastname, id)
	navigateToStudentsTab()
	newLink =  @@driver.find_element(:id => "new-link") 
	newLink.click
	@@driver.find_element(:class => "new-form") 
	@@driver.find_element(:id => "firstname").send_keys firstname
	@@driver.find_element(:id => "middlename").send_keys middlename
	@@driver.find_element(:id => "lastname").send_keys lastname
	@@driver.find_element(:id => "id").send_keys id
	@@driver.find_element(:name => "commit").click
end
