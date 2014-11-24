class SubmissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        # Admins can see their own school
        when 'Admin'
          scope.where(student_id: user.school.students.map(&:id))
        # Teachers can see their own assignments
        when 'Teacher'
          scope.where(assignment_id: user.account.assignments.map(&:id))
        # Students can see their own submissions
        when 'Student'
          scope.where(id: user.account.submissions.map(&:id))
      end
    end
  end
end
