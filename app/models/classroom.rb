# @author: elewis, jdefond

class Classroom < ActiveRecord::Base

	#more then one teacher and more then one student per class, but teachers and
  belongs_to :school
	#students also have more then one class
	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :students

    has_many :attendance
    has_many :events
    has_many :assignments, :dependent => :destroy

    validates :name, presence: true, uniqueness: true
    validates :student_capacity, numericality: { greater_than_or_equal_to: 0 }
    validate  :enforce_student_capacity

    before_validation :default_values, on: :create

    # Return current maximum possible points for this class
    def max_points
        assignments.sum(:max_points)
    end

    # Return all assignments with future due datetime
    def current_assignments
        currentAssignments = []
        for a in assignments.order('due ASC')
            if a.due > DateTime.now
                currentAssignments.append(a)
            end
        end
        return currentAssignments
    end

    # Return all assignments with past due datetime
    def past_assignments
        pastAssignments = []
        for a in assignments.order('due DESC')
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
end
