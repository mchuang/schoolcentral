require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'


open()

login("test_teacher", "password")
selectClassroom("test_class")
toGradesTab()

editGrade("1", "Iteration 2 doc", 100)
toGradesTab()
verify("100", getGrade("test_student", "Iteration 2 doc"))

logout()

close()