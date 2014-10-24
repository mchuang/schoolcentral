class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    
    def resolve
      type = user.account_type
      case type
    		# Admins can see everything
        when 'Admin'
          scope.all
    		# Teachers can see only their own classes
        when 'Teacher'
          scope.where({id: user.account.classrooms.map(&:id)})
        # Students can see only their own classes
        when 'Student'
          scope.where({id: user.account.classrooms.map(&:id)})
      end
    end
  end
end
