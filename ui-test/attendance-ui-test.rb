require_relative 'lib-ui-test'
require_relative 'lib-ui-test-iter2'

open()

login("test_teacher", "password")
selectClassroom("test_class")
toAttendanceTab()

logout()

close()