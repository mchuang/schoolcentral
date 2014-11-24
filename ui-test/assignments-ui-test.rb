require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'


open()

login("test_teacher", "password", "ths")
selectClassroom("test_class")
toAssignmentsTab()

verify(true, hasCurrentAssignment("Final Presentation"))
verify("December 19, 2014 at 3:00 pm", getCurrentAssignmentDueDate("Final Presentation"))

selectCurrentAssignment("Final Presentation")
navBarHome()
selectClassroom("test_class")
toAssignmentsTab()

verify(true, hasPastAssignment("Mini-lecture Presentation"))
verify("November 19, 2014 at 5:30 pm", getPastAssignmentDueDate("Mini-lecture Presentation"))
selectPastAssignment("Mini-lecture Presentation")
navBarHome()

logout()
close()