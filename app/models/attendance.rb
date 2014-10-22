class Attendance < ActiveRecord::Base
    belongs_to :student
    belongs_to :classroom

    @@PRESENT = 0
    @@TARDY   = 1
    @@ABSENT  = 2


    # Perhaps add excused or unexcused tag

    # Create multiple attendance objects to represent a meeting
    # of the given classroom on the given date. absent and tardy
    # should be arrays of student ids in the class. Attendance
    # status defaults to present for all others
    def self.add_class(classroom, date, absent=[], tardy=[])
        classroom.students.each {|std|
            if absent.include? std.id
                status = @@ABSENT
            elsif tardy.include? std.id
                status = @@TARDY
            else
                status = @@PRESENT
            end
            Attendance.create(
                :classroom_id => classroom.id,
                :student_id => std.id,
                :date => date,
                :status => status
            )
        }
    end

    def get_status
        case status
            when @@PRESENT
                :present
            when @@TARDY
                :tardy
            when @@ABSENT
                :absent
            else
                :error
        end
    end

    def present?
        status == @@PRESENT
    end

    def tardy?
        status == @@TARDY
    end

    def absent?
        status == @@ABSENT
    end
end
