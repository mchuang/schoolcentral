# @author: elewis, jdefond

class SchoolPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        # Admins can see their own school
        when 'Admin'
          scope.where(id: user.school_id)
        # Teachers can see their own school
        when 'Teacher'
          scope.where(id: user.school_id)
        # Students can see their own school
        when 'Student'
          scope.where(id: user.school_id)
      end
    end
  end
end
