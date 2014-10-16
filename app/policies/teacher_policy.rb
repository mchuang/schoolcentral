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
    		when 'Admin'
    			scope.all
    		when 'Teacher'
    		  scope.where({id: user.account_id})
    		when 'Student'
    			scope.all
    	end
    end
  end
end
