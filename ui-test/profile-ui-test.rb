require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'
require_relative 'lib-profile-ui-test'

open()

login("test_teacher", "password")
toProfile()
editPassword("password", "password!")
editAddress("Soda Hall")
editPhoneNumber("123-456-7890")
editEmail("cs169@cory.eecs.berkeley.edu")
logout()
login("test_teacher", "password!")
toProfile()
editPassword("password!", "password")
editAddress("")
editPhoneNumber("")
editEmail("")
logout()

close()