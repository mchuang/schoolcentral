class SubmissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        # Admins can see their own school
        when 'Admin'
          # scope.where({id:user.school(&:id)})
        scope.all
        # Teachers can see their own school
        when 'Teacher'
          scope.where({assignment_id: user.account.assignments.map(&:id)})
        # scope.all
        # Students can see their own school
        when 'Student'
          scope.where({id:user.account.submissions.map(&:id)})
        # scope.all
      end
    end
  end
end
