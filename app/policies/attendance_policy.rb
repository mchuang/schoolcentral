# @author: elewis, jdefond

class AttendancePolicy < ApplicationPolicy

  def index?
    true
  end

  # Not applicable for attendance
  def show?
    false
  end

  def create?
    ["Admin", "Teacher"].include? user.account_type
  end

  def new?
    create?
  end

  def update?
    user.account_type == "Admin" or (user.account_type == "Teacher" and user.account.classrooms.include? record.classroom)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      case user.account_type
        # Admins can see everything
        when 'Admin'
          scope.all
        # Teachers can see only their own students
        when 'Teacher'
          scope.where(classroom_id: user.account.classrooms.map(&:id))
        # Students can see only their own attendance records
        when 'Student'
          scope.where(student_id: user.account_id)
      end
    end
  end
end
