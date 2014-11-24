require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'

open()

login("test_teacher", "password")
selectClassroom("test_class")
toStudentsTab()
verify(hasStudent("test_student"), true)
verify("test_student@fake.com", getStudentEmail("test_student"))

logout()

close()