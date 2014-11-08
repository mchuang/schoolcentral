require 'rubygems'
require 'selenium-webdriver'

@@driver = Selenium::WebDriver.for :firefox
@@wait = Selenium::WebDriver::Wait.new(:timeout => 10)
def open
	@@driver.get "http://localhost:3000"
end

def close
	@@driver.quit
end

def login(username_input, password_input)
	loginBtn = @@wait.until { @@driver.find_element :id => "login-menu" }
	loginBtn.click

	@@wait.until { @@driver.find_element(:id => "new_user") }
	username = @@driver.find_element :id => "username-field"
	password = @@driver.find_element :id => "password-field"

	username.send_keys username_input
	password.send_keys password_input

	loginBtn = @@driver.find_element :id => "login-button"
	loginBtn.click
	@@wait.until { @@driver.find_element(:class => "profile-display") }
end

def selectClassroom(classroom)
	classroomTab = @@wait.until { @@driver.find_element(:id => classroom) }
	classroomTab.click
end

def navigateToProfile
	profileBtn = @@wait.until { @@driver.find_element(:id => "profile-path") }
	profileBtn.click
end

def navigateToAssignmentsTab
	assignmentsTab = @@wait.until { @@driver.find_element(:id => "assignments-tab") }
	assignmentsTab.click
end

def navigateToStudentsTab
	studentsTab = @@wait.until { @@driver.find_element(:id => "students-tab") }
	studentsTab.click
end

def navigateToGradesTab
	gradesTab = @@wait.until { @@driver.find_element(:id => "grades-tab") }
	gradesTab.click
end

def navigateToAttendanceTab
	attendanceTab = @@wait.until { @@driver.find_element(:id => "attendance-tab") }
	attendanceTab.click
end

def navigateToClassroomsAdminTab
	classroomsTab = @@wait.until { @@driver.find_element(:id => "classrooms-tab") }
	classroomsTab.click
end

def navigateToStudentsAdminTab
	studentsTab = @@wait.until { @@driver.find_element(:id => "students-tab") }
	studentsTab.click
end

def navigateToTeachersAdminTab
	teachersTab = @@wait.until { @@driver.find_element(:id => "teachers-tab") }
	teachersTab.click
end

def createClassroom(teacher, students, course, time, description, capacity)
	navigateToClassroomsAdminTab()
	newLink = @@wait.until { @@driver.find_element(:id => "new-link") }
	newLink.click
	@@wait.until { @@driver.find_element(:class => "new-form") }
	@@driver.find_element(:id => "teacher").send_keys teacher
	@@driver.find_element(:id => "students").send_keys students
	@@driver.find_element(:id => "name").send_keys course
	@@driver.find_element(:id => "time").send_keys time
	@@driver.find_element(:id => "description").send_keys description
	@@driver.find_element(:id => "capacity").send_keys capacity
	@@driver.find_element(:name => "commit").click
end

def editClassroom(classroom, teachers, students, course, time, description, capacity)
	navigateToClassroomsAdminTab()
	infoLink = @@wait.until { @@driver.find_element(:id => classroom) }
	infoLink.click
	@@wait.until { @@driver.find_element(:class => "class-info") }
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
	newLink = @@wait.until { @@driver.find_element(:id => "new-link") }
	newLink.click
	@@wait.until { @@driver.find_element(:class => "new-form") }
	@@driver.find_element(:id => "firstname").send_keys firstname
	@@driver.find_element(:id => "middlename").send_keys middlename
	@@driver.find_element(:id => "lastname").send_keys lastname
	@@driver.find_element(:id => "id").send_keys id
	@@driver.find_element(:name => "commit").click
end

def createStudent(firstname, middlename, lastname, id)
	navigateToStudentsTab()
	newLink = @@wait.until { @@driver.find_element(:id => "new-link") }
	newLink.click
	@@wait.until { @@driver.find_element(:class => "new-form") }
	@@driver.find_element(:id => "firstname").send_keys firstname
	@@driver.find_element(:id => "middlename").send_keys middlename
	@@driver.find_element(:id => "lastname").send_keys lastname
	@@driver.find_element(:id => "id").send_keys id
	@@driver.find_element(:name => "commit").click
end

def getClassroomTableAdmin
	navigateToClassroomsAdminTab()
	classroomsTable = @@wait.until { @@driver.find_elements(:id => "tableData")}
	return classroomsTable
end

def getTeacherTableAdmin
	navigateToTeachersAdminTab()
	teachersTable = @@wait.until { @@driver.find_elements(:id => "tableData")}
	return teachersTable
end

def getStudentTableAdmin
	navigateToStudentsAdminTab()
	studentsTable = @@wait.until { @@driver.find_elements(:id => "tableData")}
	return studentsTable
end

def findUser(user_id)
end

def findAssignment(assignment_id)
end

def findAttendance(user_id)
end

open()
login("test_admin", "password")
editClassroom("5", "test_teacher", "cls_student_1", "ap chem", "", "", 20)
