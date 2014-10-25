# @author: elewis, jdefond

class AttendancePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.account_type
        # Admins can see everything
        when 'Admin'
          scope.all
        # Teachers can see only their own students
        when 'Teacher'
          scope.where(classroom_id: user.account.classrooms.map(&:id))
        # Students can see only their own attendance records
        when 'Student'
          scope.where(student_id: user.account_id)
      end
    end
  end
end
