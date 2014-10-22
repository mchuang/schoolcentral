# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.where(identifier: "test_admin").delete_all
User.where(identifier: "test_teacher").delete_all
User.where(identifier: "test_student").delete_all

puts "Creating test Admin..."
test_admin = User.create_account("Admin", {
    :identifier => "test_admin",
    :email => "test_admin@fake.com",
    :password => "password",
    :password_confirmation => "password"
})

puts "Creating test Teacher..."
test_teacher = User.create_account("Teacher", {
    :identifier => "test_teacher",
    :email => "test_teacher@fake.com",
    :password => "password",
    :password_confirmation => "password"
})

puts "Creating test Student..."
test_student = User.create_account("Student", {
    :identifier => "test_student",
    :email => "test_student@fake.com",
    :password => "password",
    :password_confirmation => "password"
})



Classroom.where(name: "test_class").delete_all

nstudents = 20
puts "Creating test Classroom with #{nstudents} students"
cls = Classroom.create(
    :name => "test_class",
    :time => "12:00",
    :location => "Room 404",
    :description => "Test classroom with multiple students",
    :student_capacity => 30
)
# Add test_teacher and test_student to new class
cls.teachers << test_teacher
cls.students << test_student
# Enroll additional students
(0...nstudents).each do |sid|
    # Remove existing seeded users and student accounts
    User.where(identifier: "cls_student_#{sid}").delete_all

    # Replace with new Student in class
    cls.students << User.create_account("Student", {
        :identifier => "cls_student_#{sid}",
        :email => "cls_student_#{sid}@fake.com",
        :password => "password",
        :password_confirmation => "password",
    })
    print "."
end
puts
cls.save
