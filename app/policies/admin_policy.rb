# @author: elewis, jdefond

class AdminPolicy < ApplicationPolicy

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
    user.id == record.user.id
  end

  def edit?
    update?
  end

  def destroy?
    user.id == record.user.id
  end

  class Scope < Scope
    def resolve
      type = user.account_type
      case type
        when 'Admin'
          user.school.admins
        when 'Teacher'
          user.school.admins
        when 'Student'
          user.school.admins
      end
    end
  end
end
