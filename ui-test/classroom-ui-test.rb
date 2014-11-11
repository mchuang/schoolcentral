require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'

open()

login("test_teacher", "password")
selectClassroom("test_class")

assertIdElementExists("profile-display")
assertIdElementExists("classlist")

assertIdElementExists("sub-tabs")
assertIdElementExists("students-tab")
assertIdElementExists("assignments-tab")
assertIdElementExists("attendance-tab")
assertIdElementExists("grades-tab")

assertIdElementExists("tab-content")
assertIdElementExists("students-content")
assertIdElementExists("assignments-content")
assertIdElementExists("attendance-content")
assertIdElementExists("grades-content")

logout()

login("test_student", "password")
selectClassroom("test_class")

assertIdElementExists("profile-display")
assertIdElementExists("classlist")

assertIdElementExists("sub-tabs")
assertIdElementNotExists("students-tab")
assertIdElementExists("assignments-tab")
assertIdElementExists("attendance-tab")
assertIdElementExists("grades-tab")

assertIdElementExists("tab-content")
assertIdElementNotExists("students-content")
assertIdElementExists("assignments-content")
assertIdElementExists("attendance-content")
assertIdElementExists("grades-content")

logout()

close()