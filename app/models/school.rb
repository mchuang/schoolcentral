# @author: elewis, jdefond

class School < ActiveRecord::Base
    has_many :classrooms
    has_many :users

    validates :name, uniqueness: true

    def admins
        Admin.where(id: users.where(account_type: "Admin").select(:account_id))
    end

    def teachers
        Teacher.where(id: users.where(account_type: "Teacher").select(:account_id))
    end

    def students
        Student.where(id: users.where(account_type: "Student").select(:account_id))
    end
end
