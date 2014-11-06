# @author: elewis, jdefond

class ClassroomPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.account_type == "Admin" or user.account.classrooms.include? record
  end

  def create?
    user.account_type == "Admin"
  end

  def new?
    create?
  end

  def update?
    user.account_type == "Admin" or (user.account_type == "Teacher" and user.account.classrooms.include? record)
  end

  def edit?
    update?
  end

  def destroy?
    user.account_type == "Admin"
  end

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
