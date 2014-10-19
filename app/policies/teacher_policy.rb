class TeacherPolicy < ApplicationPolicy
  class Scope < Scope
  	attr_reader :user, :scope

  	def initialize(user,scope)
  		@user = user
  		@scope = scope
  	end
    
    def resolve
    	type = user.account_type
    	case type
        # Admins can see everything
    		when 'Admin'
    			scope.all
        # Teachers can see only themselves
    		when 'Teacher'
    		  scope.where(id: user.account_id)
        # Students can see only their own teachers (maybe change?)
    		when 'Student'
          scope.where(id: user.account.teachers.map(&:id))
      end
    end
  end
end
