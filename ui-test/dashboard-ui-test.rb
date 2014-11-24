require_relative 'lib-basic-ui-test'
require_relative 'lib-dashboard-ui-test'

open()

login("test_teacher", "password", "ths")

assertIdElementExists("profile-display")
assertIdElementExists("classlist")
assertIdElementExists("calendar-content")
assertIdElementExists("day-feed-panel-body")

verify(true, hasDayInfoFeed())
verify(true, hasCalendar())

logout()

close()