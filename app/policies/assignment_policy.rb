class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        # Admins can see all
        when 'Admin'
          scope.where({id:user.school(&:id)})
        # scope.all
        # Teachers can see their own school
        when 'Teacher'
          scope.where({id:user.school(&:id)})
        # scope.all
        # Students can see their own school
        when 'Student'
          scope.where({id:user.school(&:id)})
        # scope.all
      end
    end
  end
end
