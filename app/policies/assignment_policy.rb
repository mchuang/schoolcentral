class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        # Admins can see all
        when 'Admin'
        scope.all
        # Teachers can see their own school
        when 'Teacher'
          scope.where({id:user.account.assignments.map(&:id)})
        # scope.all
        # Students can see their own school
        when 'Student'
          scope.where({classroom_id:user.account.classrooms.map(&:id)})
        # scope.all
      end
    end
  end
end
