require 'rubygems'
require 'selenium-webdriver'

@@driver = Selenium::WebDriver.for :firefox
@@driver.manage.timeouts.implicit_wait = 10
@@wait = Selenium::WebDriver::Wait.new(:timeout => 10)
def open
	@@driver.get "http://localhost:3000"
end

def close
	@@driver.quit
end

def login(username_input, password_input)
	navBarLogin()
	@@driver.find_element(:id => "new_user") 
	username = @@driver.find_element :id => "username-field"
	password = @@driver.find_element :id => "password-field"

	username.send_keys username_input
	password.send_keys password_input

	loginBtn = @@driver.find_element :id => "login-button"
	loginBtn.click
	@@driver.find_element(:class => "profile-display") 
end

def logout
	logoutBtn =  @@driver.find_element :id => "logout-btn" 
	logoutBtn.click

	@@driver.find_element :class => "jumbotron"
end

def selectClassroom(classroom)
	classroomTab =  @@driver.find_element(:id => classroom) 
	classroomTab.click
end

def navBarLogin
	navBar =  @@driver.find_element :class => "navbar"
	loginBtn = navBar.find_element :id => "login-menu"
	loginBtn.click

	@@driver.find_element(:id => "new_user") 
end

def navBarHome
	navBar =  @@driver.find_element :class => "navbar"
	homeBtn = navBar.find_element :tag_name => "img"
	homeBtn.click
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

def editPassword(oldpassword, newpassword)
	pwPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[2]
	pwPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_current_password").send_keys oldpassword
	@@driver.find_element(:id => "user_password").send_keys newpassword
	@@driver.find_element(:id => "user_password_confirmation").send_keys newpassword
	@@driver.find_element(:id => "save-cancel-password").click
end

def editEmail(email)
	emailPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[3]
	emailPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_email").send_keys email
	@@driver.find_element(:id => "save-cancel-email").click
end

def editPhoneNumber(phoneNumber)
	pnPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[4]
	pnPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_phone").send_keys phone
	@@driver.find_element(:id => "save-cancel-phone").click
end

def editAddress(address)
	addrPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[5]
	addrPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_address").send_keys address
	@@driver.find_element(:id => "save-cancel-address").click
end

def toAssignmentsTab
	assignmentsTab =  @@driver.find_element(:id => "assignments-tab") 
	assignmentsTab.click
	@@driver.find_element(:id => "assignments-content") 
end

def toStudentsTab
	studentsTab =  @@driver.find_element(:id => "students-tab") 
	studentsTab.click
	@@driver.find_element(:id => "students-content") 
end

def toGradesTab
	gradesTab =  @@driver.find_element(:id => "grades-tab") 
	gradesTab.click
	@@driver.find_element(:id => "grades-content") 
end

def toAttendanceTab
	attendanceTab =  @@driver.find_element(:id => "attendance-tab") 
	attendanceTab.click
	@@driver.find_element(:id => "attendance-content") 
end

def toClassroomsAdminTab
	classroomsTab =  @@driver.find_element(:id => "classrooms-tab") 
	classroomsTab.click
	@@driver.find_element(:id => "tableData") 
end

def toStudentsAdminTab
	studentsTab =  @@driver.find_element(:id => "students-tab") 
	studentsTab.click
	@@driver.find_element(:id => "tableData") 
end

def toTeachersAdminTab
	teachersTab =  @@driver.find_element(:id => "teachers-tab") 
	teachersTab.click
	@@driver.find_element(:id => "tableData") 
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

def getClassroomTableAdmin
	navigateToClassroomsAdminTab()
	classroomsTable =  @@driver.find_elements(:id => "tableData")
	return classroomsTable
end

def getTeacherTableAdmin
	navigateToTeachersAdminTab()
	teachersTable =  @@driver.find_elements(:id => "tableData")
	return teachersTable
end

def getStudentTableAdmin
	navigateToStudentsAdminTab()
	studentsTable =  @@driver.find_elements(:id => "tableData")
	return studentsTable
end

def findUser(user_id)
end

def findAssignment(assignment_id)
end

def findAttendance(user_id)
end

