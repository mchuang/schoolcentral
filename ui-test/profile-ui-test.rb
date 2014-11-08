require_relative 'lib-ui-test'

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
logout()

close()