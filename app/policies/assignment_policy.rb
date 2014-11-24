class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        # Admins can see all assignments for their school
        when 'Admin'
          scope.where(classroom_id: user.school.classrooms.map(&:id))
        # Teachers can see their own assignments
        when 'Teacher'
          scope.where(id: user.account.assignments.map(&:id))
        # Students can see their own classrooms assignments
        when 'Student'
          scope.where(classroom_id: user.account.classrooms.map(&:id))
      end
    end
  end
end
