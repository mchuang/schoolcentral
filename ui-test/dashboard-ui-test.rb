require_relative 'lib-basic-ui-test'

open()

login("test_teacher", "password")

assertIdElementExists("profile-display")
assertIdElementExists("classlist")
assertIdElementExists("calendar-content")
assertIdElementExists("day-feed-panel-body")

logout()

close()