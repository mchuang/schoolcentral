# @author: elewis, jdefond

class AdminPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        when 'Admin'
          scope.all
        when 'Teacher'
          scope.all
        when 'Student'
          scope.all
      end
    end
  end
end
