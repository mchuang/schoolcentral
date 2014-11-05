# @author: elewis, jdefond

class StudentPolicy < ApplicationPolicy

  def index?
    ["Admin", "Teacher"].include? user.account_type
  end

  def show?
    case user.account_type
      when "Admin"
        true
      when "Teacher"
        user.account.students.include? record
      when "Student"
        user.account_id == record.id
    end
  end

  def create?
    user.account_type == "Admin"
  end

  def new?
    create?
  end

  def update?
    user.account_type == "Admin" or (user.account_type == "Student" and user.account_id == record.id)
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
