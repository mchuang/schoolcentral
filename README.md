README
=======

INSTALL
-------

$ git clone  
$ bundle install  
$ rake db:create db:schema:load db:seed
$ rails server  
navigate to http://localhost:3000  

TESTING
-------

test_admin => {Username: “test_admin”, Password: “password”}  
test_teacher => {Username: “test_teacher”, Password: “password”}  
test_student => {Username: “test_student”, Password: “password”}  

Currently to test the features of this app, sign in as one of these users.

Create a new user: 
- Log in as admin
- Go to Students or Teachers tab
- Click New above the table 
- Input a unique identifier in ID field
- Click create new student/teacher
- Redirected to the users table again with the new user

Create a classroom: 
- Log in as admin
- Go to Classrooms tab 
- Click New above the table 
- Input the identifiers for existing teachers and students (for multiple students {id0, id1, id2}) ie Teacher: test_teacher / Students: cls_student_0, cls_student_1, cls_student_2
- Input a positive integer for capacity (30)
- Click create new classroom
- Redirected to classrooms table with newly created class            

Change attendance: 
- Log in as test_student
- Go to test_class tab
- Go to attendance tab
- take note of student attendance for test_class
- Logout
- Log in as test_teacher
- Go to test_class tab
- Go to attendance tab
- Click on date
- Change test_student attendance for that date
- Logout
- Repeat test_student steps

Change profile info:
- Log in as test_teacher
- Click on profile button in navbar or the profile thumbnail
- Click the edit button for any user attribute
- Fill in the input fields
- Click save
- Verify changes were stored
