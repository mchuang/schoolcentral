require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-classroom-ui-test'
require_relative 'lib-profile-ui-test'

open()

login("test_teacher", "password", "ths")
selectClassroom("test_class")
toStudentsTab()
verify(hasStudent("test_student"), true)
verify("test_student@fake.com", getStudentEmail("test_student"))

verify(hasStudent("cls_student_1"), true)
verify("cls_student_1@fake.com", getStudentEmail("cls_student_1"))

verify(hasStudent("cls_student_10"), true)
verify("cls_student_10@fake.com", getStudentEmail("cls_student_10"))

logout()

login("test_student", "password", "ths")
toProfile()
verify("test_student@fake.com", getEmail())
logout()

login("cls_student_1", "password", "ths")
toProfile()
verify("cls_student_1@fake.com", getEmail())
logout()

login("cls_student_10", "password", "ths")
toProfile()
verify("cls_student_10@fake.com", getEmail())
logout()

close()