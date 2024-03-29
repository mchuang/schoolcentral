# @author: elewis, jdefond, voe

class Attendance < ActiveRecord::Base
    belongs_to :student
    belongs_to :classroom

    validates_inclusion_of :status, in: 0..2

    @@PRESENT = 0
    @@TARDY   = 1
    @@ABSENT  = 2

    # Perhaps add excused or unexcused tag

    # Create multiple attendance objects to represent a meeting
    # of the given classroom on the given date. options[:absent]
    # and options[:tardy] should be arrays of student ids in the
    # class. Attendance status defaults to present for all others
    #
    # Existing attendance records are updated in place
    def self.add_class(classroom, date, options={})
        absent = options.fetch(:absent, [])
        tardy  = options.fetch(:tardy,  [])
        date   = date.beginning_of_day
        classroom.students.each {|std|
            if absent.include? std.id
                status = @@ABSENT
            elsif tardy.include? std.id
                status = @@TARDY
            else
                status = @@PRESENT
            end
            att = Attendance.where(
                classroom_id: classroom.id,
                student_id: std.id,
                date: date
            ).first_or_initialize
            att.status = status
            att.save!
        }
    end

    def self.get_date_range_for_student(student, classroom, start_d, end_d)
        student.attendance.where('classroom_id = ?', classroom.id).where('date BETWEEN ? AND ?', start_d, end_d)
    end

    def self.get_week_for_student(student, classroom, date)
        get_date_range_for_student(student, classroom, date.beginning_of_week, date.end_of_week)
    end

    def self.get_week_array(date)
        (date.beginning_of_week..date.end_of_week).to_a
    end

    # Returns all attendance objects for the given class with dates
    # between start_date and end_date (both inclusive)
    def self.get_date_range(classroom, start_d, end_d)
        classroom.attendance.where('date BETWEEN ? AND ?', start_d, end_d)
    end

    # Return attendance for the week of date (Monday - Sunday)
    def self.get_week(classroom, date)
        get_date_range(classroom, date.beginning_of_week, date.end_of_week)
    end

    # Return attendance for the month of date
    def self.get_month(classroom, date)
        get_date_range(classroom, date.beginning_of_month, date.end_of_month)
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
