require_relative 'lib-basic-ui-test'
require_relative 'lib-classroom-ui-test'

open()

login("test_teacher", "password")
selectClassroom("test_class")
toAttendanceTab()

logout()

close()