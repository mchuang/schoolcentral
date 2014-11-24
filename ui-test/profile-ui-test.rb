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
verify("cs169@cory.eecs.berkeley.edu", getEmail())
verify("Soda Hall", getAddress())
verify("123-456-7890", getPhoneNumber())
logout()
login("test_teacher", "password!")
toProfile()
verify("cs169@cory.eecs.berkeley.edu", getEmail())
verify("Soda Hall", getAddress())
verify("123-456-7890", getPhoneNumber())
editPassword("password!", "password")
editAddress("")
editPhoneNumber("")
editEmail("")
logout()

close()