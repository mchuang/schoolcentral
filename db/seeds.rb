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
u1 = User.create(
    :identifier => "test_admin",
    :email => "test_admin@fake.com",
    :password => "password",
    :password_confirmation => "password",
    :account_id => Admin.create().id,
    :account_type => "Admin"
)

puts "Creating test Teacher..."
u2 = User.create(
    :identifier => "test_teacher",
    :email => "test_teacher@fake.com",
    :password => "password",
    :password_confirmation => "password",
    :account_id => Teacher.create().id,
    :account_type => "Teacher"
)

puts "Creating test Student..."
u3 = User.create(
    :identifier => "test_student",
    :email => "test_student@fake.com",
    :password => "password",
    :password_confirmation => "password",
    :account_id => Student.create().id,
    :account_type => "Student"
)
