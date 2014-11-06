# @author: elewis, jdefond

class Admin < ActiveRecord::Base
	#Admin has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy

    def events
        Event.where(classroom_id: user.school.classrooms.map(&:id))
    end
end
