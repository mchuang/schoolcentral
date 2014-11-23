require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'


open()

login("test_teacher", "password")
selectClassroom("test_class")
toGradesTab()

editGrade("test_student", "Iteration 2 doc", 100)

logout()

close()