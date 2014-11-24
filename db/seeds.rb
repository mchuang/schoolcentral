# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

School.where(identifier: "ths").delete_all

puts "Creating test School..."
school = School.create(
    :name => "Test High School",
    :identifier => "ths",
)

User.where(first_name: "TEST").delete_all

puts "Creating test Admin..."
test_admin = User.create_account("Admin", {
    :identifier => "test_admin",
    :email => "test_admin@fake.com",
    :first_name => "TEST",
    :password => "password",
    :password_confirmation => "password",
    :school => school,
})

puts "Creating test Teacher..."
test_teacher = User.create_account("Teacher", {
    :identifier => "test_teacher",
    :email => "test_teacher@fake.com",
    :first_name => "TEST",
    :password => "password",
    :password_confirmation => "password",
    :school => school,
})
test_teacher2 = User.create_account("Teacher", {
    :identifier => "test_teacher2",
    :email => "test_teacher2@fake.com",
    :first_name => "TEST",
    :password => "password",
    :password_confirmation => "password",
    :school => school,
})

puts "Creating test Student..."
test_student = User.create_account("Student", {
    :identifier => "test_student",
    :email => "test_student@fake.com",
    :first_name => "TEST",
    :password => "password",
    :password_confirmation => "password",
    :school => school,
})


Classroom.where(description: "TEST").delete_all

nstudents = 20
puts "Creating test Classrooms with #{nstudents} students"
cls1 = school.classrooms.create(
    :name => "test_class",
    :time => "12:00",
    :location => "Room 404",
    :description => "TEST"
)
cls2 = school.classrooms.create(
    :name => "test_class2",
    :time => "1:00",
    :location => "Room 500",
    :description => "TEST"
)
cls3 = school.classrooms.create(
    :name => "test_class3",
    :time => "2:00",
    :location => "Room 200 OK",
    :description => "TEST"
)
cls4 = school.classrooms.create(
    :name => "test_class4",
    :time => "3:00",
    :location => "Room 304 NOT MODIFIED",
    :description => "TEST"
)

# Assign teachers
cls1.teachers << test_teacher
cls2.teachers << test_teacher2
cls3.teachers << test_teacher
cls4.teachers << test_teacher

# Assign students
cls1.students << test_student
cls2.students << test_student

# Enroll additional students
(0...nstudents).each do |sid|
    std = User.create_account("Student", {
        :identifier => "cls_student_#{sid}",
        :email => "cls_student_#{sid}@fake.com",
        :first_name => "TEST",
        :password => "password",
        :password_confirmation => "password",
        :school => school,
    })
    cls1.students << std
    cls2.students << std
    print "."
end

# Assign students randomly to cls3 and cls4
students = school.students.all.to_a
(0...(nstudents/2)).each do |sid|
    cls3.students << students.delete_at(rand(students.length))
end
(0...(nstudents/2)).each do |sid|
    cls4.students << students.delete_at(rand(students.length))
end
puts

puts "Creating assignments for test_class..."
now = Time.zone.now
asgn0 = cls1.assignments.create(
    :teacher => test_teacher,
    :name => "Iteration 2 doc",
    :max_points => 100,
    :due => DateTime.new(2014, 10, 31, 22, 0, 0)
)
asgn1 = cls1.assignments.create(
    :teacher => test_teacher,
    :name => "Iteration 2 code",
    :max_points => 100,
    :due => DateTime.new(2014, 11, 7, 22, 0, 0)
)
asgn2 = cls1.assignments.create(
    :teacher => test_teacher,
    :name => "Iteration 3 doc",
    :max_points => 100,
    :due => DateTime.new(2014, 11, 14, 22, 0, 0)
)
asgn3 = cls1.assignments.create(
    :teacher => test_teacher,
    :name => "Iteration 3 code",
    :max_points => 100,
    :due => DateTime.new(2014, 11, 21, 22, 0, 0)
)
asgn4 = cls1.assignments.create(
    :teacher => test_teacher,
    :name => "Mini-lecture Presentation",
    :max_points => 150,
    :due => DateTime.new(2014, 11, 19, 17, 30, 0)
)
asgn5 = cls1.assignments.create(
    :teacher => test_teacher,
    :name => "Final Presentation",
    :max_points => 300,
    :due => DateTime.new(2014, 12, 19, 15, 0, 0)
)

nassignments = 20
teachers = school.teachers.all
classrooms = school.classrooms.all
puts "Creating random assignments for other classes..."
(0...nassignments).each {|aid|
    classrooms.sample.assignments.create(
        :teacher => teachers.sample,
        :name => "RandomAssignment-#{aid}",
        :max_points => rand(50),
        :due => now + (rand(100) - 50).days + (rand(24) - 12).hours + (rand(120) - 60).minutes
    )
    print "."
}
puts
