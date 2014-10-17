class StudentPolicy < ApplicationPolicy
  class Scope < Scope
  	attr_reader :user, :scope

    def initialize(user,scope)
  		@user = user
  		@scope = scope
  	end
    
    def resolve
    	type = user.account_type
    	case type
    		#if type is 'admin' scope of student.all
    		when 'Admin'
    			scope.all
    		#if type is 'teacher' scope of student.where(:classrooms => @user.account.classrooms)
    		when 'Teacher'
          #scope = scope.includes(:classrooms)
          t = Teacher.where({id: user.account_id})
          c = t.classrooms
          s = c.students
    		  scope.where(s)
          #p scope.all
    		when 'Student'
    			scope.where({id: user.account_id})
    	end
    end
  end
end
