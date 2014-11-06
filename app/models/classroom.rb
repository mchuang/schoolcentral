# @author: elewis, jdefond

class Classroom < ActiveRecord::Base

	#more then one teacher and more then one student per class, but teachers and
  belongs_to :school
	#students also have more then one class
	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :students

    has_many :attendance
    has_many :events
    has_many :assignments

    validates :name, presence: true, uniqueness: true
    validates :student_capacity, numericality: { greater_than_or_equal_to: 0 }
    validate  :enforce_student_capacity

    before_save :default_values

    def max_points
        assignments.sum(:max_points)
    end

    def current_assignments
        currentAssignments = []
        for a in assignments
            if a.due > DateTime.now
                currentAssignments.append(a)
            end
        end
        return currentAssignments
    end

    def past_assignments
        pastAssignments = []
        for a in assignments
            if a.due < DateTime.now
                pastAssignments.append(a)
            end
        end
        return pastAssignments
    end

    private

    def enforce_student_capacity
        if student_capacity && students.count > student_capacity
            errors.add(:student_capacity, "student capacity is overloaded")
        end
    end


    def default_values
        self.student_capacity ||= 30
    end

    def self.editClassroom(course, time, location, description, capacity, teachers, students)
        @time = time
        @location = location
        @description = description
        @capacity = capacity
        teachers.clear()
        students.clear()
        teachers.split(',').each do |teacher|
            if Teacher.find_by_id(teacher)
                @teachers << Teacher.find_by_identifier(teacher).account
            end
        end
        students.split(',').each do |student|
            if Student.find_by_id(student)
                @students << Student.find_by_identifer(student).account
            end
        end
    end
end
