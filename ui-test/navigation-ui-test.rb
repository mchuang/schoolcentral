require_relative 'lib-basic-ui-test'
require_relative 'lib-admin-ui-test'
require_relative 'lib-classroom-ui-test'
require_relative 'lib-dashboard-ui-test'

open()

login("test_admin", "password", "ths")
toStudentsAdminTab()
toTeachersAdminTab()
toClassroomsAdminTab()
toProfile()
navBarHome()
clickProfDisplay()
logout()

login("test_teacher", "password", "ths")
selectClassroom("test_class")
toAssignmentsTab()
toGradesTab()
toAttendanceTab()
toStudentsTab()
toProfile()
navBarHome()
clickProfDisplay()
logout()

login("test_student", "password", "ths")
selectClassroom("test_class")
toAssignmentsTab()
toGradesTab()
toAttendanceTab()
toProfile()
navBarHome()
clickProfDisplay()
logout()

close()