require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'

open()
login("test_student", "password", "ths")
selectClassroom("test_class")
toAssignmentsTab()
selectCurrentAssignment("Final Presentation")

submission = "submission.txt"
submitCurrentAssignment(submission)

navBarHome()
selectClassroom("test_class")
toAssignmentsTab()
selectCurrentAssignment("Final Presentation")
verify("FINAL PRESENTATION", getSubmittedAssignment())

close()