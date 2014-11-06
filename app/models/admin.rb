# @author: elewis, jdefond

class Admin < ActiveRecord::Base
	#Admin has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy

    def events
        user.school.classrooms.map {|cls| cls.events}.flatten
    end
end
