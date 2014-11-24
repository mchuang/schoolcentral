# @author: elewis, jdefond

class TeacherPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.account_type == "Admin"
  end

  def new?
    create?
  end

  def update?
    user.account_type == "Admin" or (user.account_type == "Teacher" and user.account_id == record.id)
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
        # Admins can see everything for their school
        when 'Admin'
          user.school.teachers
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
