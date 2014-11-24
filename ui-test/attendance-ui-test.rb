require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'

open()

login("test_teacher", "password")
selectClassroom("test_class")
toAttendanceTab()
changeAttendance("test_student", "2014-11-24", 2)
toAttendanceTab()
verify("tardy", getAttendance("test_student, TEST", "2014-11-24"))

logout()

close()