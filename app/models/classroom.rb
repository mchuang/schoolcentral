# @author: elewis, jdefond

class Classroom < ActiveRecord::Base

	#more then one teacher and more then one student per class, but teachers and
  belongs_to :school
	#students also have more then one class
	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :students

    has_many :attendance
    has_many :events

    validates :name, presence: true, uniqueness: true
    validates :student_capacity, numericality: { greater_than_or_equal_to: 0 }
    validate  :enforce_student_capacity

    private

    def enforce_student_capacity
        if student_capacity && students.count > student_capacity
            errors.add(:student_capacity, "student capacity is overloaded")
        end
    end
end
