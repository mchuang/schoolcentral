# @author: elewis, jdefond

class StudentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
    		# Admins can see everything
        when 'Admin'
          scope.all
    		# Teachers can see only their own students
        when 'Teacher'
          scope.where(id: user.account.students.map(&:id))
        # Students can see only themselves
        when 'Student'
          scope.where(id: user.account_id)
      end
    end
  end
end
